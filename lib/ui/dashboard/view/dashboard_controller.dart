
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertask/app/app_routes.dart';
import 'package:fluttertask/data/local/session_manager.dart';
import 'package:fluttertask/data/network/repository/app_repository.dart';
import 'package:fluttertask/utility/utils.dart';
import 'package:get/get.dart';


class DashboardController extends GetxController {

  RxInt bottomNavigationIndex = 0.obs;

  RxList itemList = [].obs;

  @override
  void onInit() {
    if(StorageManager().getTimerData()!=null){
      itemList.addAll(StorageManager().getTimerData()!);
    }

  }

  @override
  void onReady() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("=======${message.data}");

    });
    super.onReady();
  }
  /// Logout current user form app
  void logout() async {
    StorageManager().clearSession();
    Get.offAllNamed(AppRoutes.dashboardPage);
  }

  // send PushNotification Api calling
  void sendNotification(String title,String body)async{
    FirebaseMessaging.instance.getToken().then((value) {
      Map<String, dynamic> params = {};
      params.putIfAbsent('to', () => value);
      params.putIfAbsent('priority', () => "high");
      params.putIfAbsent('content_available', () => true);
      params.putIfAbsent('data', () => jsonEncode({
        'body': body,
        'title': title
      }));
      params.putIfAbsent('notification', () => {
        'body': body,
        'title': title
      });

      debugPrint("=====${params}");
      AppRepository().sendNotification(params).then((value) {
        value?.fold((l) {
          Utils.showMessage(l);
          debugPrint(l.trim());
        }, (r) {
          debugPrint("dsadf${r.trim()}");
        });
      });
    });

  }

}
