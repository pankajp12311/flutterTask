import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../app/app_colors.dart';

class Utils {
  Utils._();

  /// Close keyboard
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Show common snack bar messages
  static void showMessage(String message, {snackPosition = SnackPosition.BOTTOM}) {
    Flushbar(
      message: message,
      borderRadius: BorderRadius.circular(10.r),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      backgroundColor: AppColors.primaryColor,
      flushbarPosition: FlushbarPosition.TOP,
      borderColor: AppColors.colorWhite,
      // isDismissible: true,
      duration: const Duration(seconds: 3),
    ).show(Get.context as BuildContext);
  }

  /// Get device id for device
  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return Future.value(iosDeviceInfo.identifierForVendor);
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return Future.value(androidDeviceInfo.id);
    } else {
      return '';
    }
  }

  /// Get device type based on platform
  static int getDeviceType() {
    if (kIsWeb) {
      return 0;
    } else if (Platform.isAndroid) {
      return 1;
    } else if (Platform.isIOS) {
      return 2;
    } else {
      return -1;
    }
  }

  /// Show popup dialog with title and message
  static void showPopupDialog(String title, String message,
      {bool isDismissible = false,
        String? textConfirm,
        Future<bool> Function()? onWillPop,
        VoidCallback? onConfirm,
        Color? confirmTextColor}) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 18.sp, color: AppColors.colorBlack),
      middleText: message,
      barrierDismissible: isDismissible,
      textConfirm: textConfirm,
      onWillPop: onWillPop,
      buttonColor: AppColors.primaryColor,
      onConfirm: onConfirm,
      radius: 10.r,
      confirmTextColor: AppColors.colorWhite,
    );
  }
 // Select Time method
  static Future<TimeOfDay?> selectTime(
      BuildContext context, TimeOfDay? initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dialOnly,

      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
      },
    );

    return picked;
  }



}
