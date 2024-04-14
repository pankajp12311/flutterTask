import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertask/app/app_colors.dart';
import 'package:fluttertask/app/app_routes.dart';
import 'package:fluttertask/data/local/session_manager.dart';
import 'package:fluttertask/ui/dashboard/view/dashboard_controller.dart';
import 'package:fluttertask/utility/count_down_view.dart';
import 'package:fluttertask/widgets/common_text.dart';
import 'package:get/get.dart';


class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: AppBar(
          backgroundColor: AppColors.colorWhite, centerTitle: true,
          title: CommonMontserratText(text: "Item List", textSize: 17.sp),
          actions: [
            GestureDetector(
              onTap: () {

                Get.toNamed(AppRoutes.addItemPage)!.then((value) {
                  if (value != null) {
                    controller.itemList.add(value);

                  }
                });
              },
              child: const Icon(Icons.add),),
            SizedBox(width: 15.w,)
          ],
        ),

        body: Column(children: [

          SizedBox(height: 10.h,),
          Expanded(child:controller.itemList.isEmpty?Center(child: CommonMontserratText(text: "No Item Found.", textSize: 12.sp),): ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                return Column(
                  children: [
                    Container(
                      height: 80.h,
                      width: Get.width,
                      decoration: BoxDecoration(border: Border.all(
                          color: AppColors.colorBlack, width: 1.w),borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w,),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonMontserratText(
                                  text: controller.itemList[index]["title"],
                                  textSize: 13.sp),
                              SizedBox(height: 7.h,),
                              CommonMontserratText(
                                  text: controller
                                      .itemList[index]["description"],
                                  textSize: 13.sp)
                            ],)),
                          CountDownText(due: DateTime.parse(
                              "${"2024-04-14"} ${controller
                                  .itemList[index]["selectedTime"]}:60"),
                            finishedText: "asd", onFinished: (value) {
                              debugPrint("asdfasdf${value}");
                              if (value == true) {


                            Future.delayed(Duration(microseconds: 100)).then((value) {
                              controller.sendNotification(controller.itemList[index]["title"],"Your Item has been Expired.");
                              List? storedList = StorageManager().getTimerData();
                              storedList!.removeWhere((element) => element["selectedTime"] == controller.itemList[index]["selectedTime"]);
                              StorageManager().setTimerData(storedList);
                              controller.itemList.removeWhere((element) => element["selectedTime"] == controller.itemList[index]["selectedTime"]);
                              controller.itemList.refresh();
                            });
                              }
                            },),
                          SizedBox(width: 15.w,),
                        ],),
                    ),
                    SizedBox(height: 15.h,)
                  ],
                );
              });
            }, itemCount: controller.itemList.length,))
        ],),
      );
    });
  }

}
