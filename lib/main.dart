import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertask/app/app_class.dart';
import 'package:fluttertask/app/app_colors.dart';
import 'package:fluttertask/app/app_routes.dart';
import 'package:fluttertask/app/app_theme.dart';
import 'package:fluttertask/data/local/session_manager.dart';
import 'package:fluttertask/widgets/common_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


Future<void> _firebaseMessagingBackgroundhandler(RemoteMessage message) async {
  getFirebaseData(message);
}
// Manage Push Notification using Local Notification
void getFirebaseData(RemoteMessage message){
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  var data = jsonDecode(message.data["data"]);
  //
  debugPrint("=======MyData${data["title"]}");
  if (message.data !={}) {
    String action = jsonEncode(message.data);

    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        data["title"],
        data["body"],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            priority: Priority.high,
            importance: Importance.max,
            setAsGroupSummary: true,
            styleInformation: const DefaultStyleInformation(true, true),
            icon: '@mipmap/ic_launcher',
            autoCancel: true,
          ),
        ),
        payload: action
    );}}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  await GetStorage.init(

  );
  String? token = StorageManager().getAuthToken(); // Check if user already logged in
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.instance.requestPermission();

  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint("=======${message.data}");
    getFirebaseData(message);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundhandler);
  HttpOverrides.global = MyHttpOverrides();
  Get.put(AppColors());
  runApp(
    MyApp(

      initialRoute: token == null ? AppRoutes.dashboardPage : AppRoutes.dashboardPage,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppTheme.designSize,
      builder: (_, widget) => GetMaterialApp(
        enableLog: true,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Task',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
        ),
        darkTheme: ThemeData.light(),
        themeMode: ThemeMode.light,
        builder: (context, widget) => getMainAppViewBuilder(context, widget),
        getPages: AppRoutes.pages,
        initialRoute: initialRoute,

      ),
    );
  }

  /// Create main app view builder
  Widget getMainAppViewBuilder(BuildContext context, Widget? widget) {
    return Obx(
          () {
        return IgnorePointer(
          ignoring: AppClass().isShowLoading.isTrue,
          child: Stack(
            children: [
              widget ?? const Offstage(),
              if (AppClass().isShowLoading.isTrue) // Top level loading ( used while api calls)
                ColoredBox(
                  color: Colors.grey.withOpacity(0.5),
                  child: const Center(
                    child: CommonProgressIndicator(color: AppColors.primaryColor),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
