import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertask/app/app_colors.dart';
import 'package:get/get.dart';


/// Common app image which handles network, assets and local file paths
class CommonProgressIndicator extends StatelessWidget {
  final Color? color;
  final Color? backGroundColor;
  final double strokeWidth;
  final double? value;

  const CommonProgressIndicator(
      {Key? key, this.color, this.backGroundColor = Colors.transparent, this.strokeWidth = 3.0, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(top: 0.w, bottom: 0.w),
      child: Center(
        child: SizedBox(
          height: 20.w,
          width: 20.w,
          child: CircularProgressIndicator(
            color: color ?? AppColors.primaryColor,
            value: value,
            backgroundColor: backGroundColor,
            strokeWidth: strokeWidth,
          ),
        ),
      ),
    );
  }
}
