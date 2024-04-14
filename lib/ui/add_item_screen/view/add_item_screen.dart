import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertask/app/app_colors.dart';
import 'package:fluttertask/data/local/session_manager.dart';
import 'package:fluttertask/ui/add_item_screen/view/add_item_controller.dart';
import 'package:fluttertask/utility/utils.dart';
import 'package:fluttertask/widgets/common_app_button.dart';
import 'package:fluttertask/widgets/common_app_input.dart';
import 'package:fluttertask/widgets/common_text.dart';
import 'package:get/get.dart';

class AddItemScreen extends GetView<AddItemController> {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: (){
          Utils.closeKeyboard();
        },
        child: Scaffold(
          appBar: AppBar(
            title: CommonMontserratText(text: "Add Item", textSize: 17.sp),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(children: [
                SizedBox(height: 50.h,),
                CommonAppInput(textEditingController:controller.titleController.value,
                  filledColor: AppColors.colorD9D9D9,
                  borderRadius: 0,
                  hintText: "Enter Title",
                ),
                SizedBox(height: 15.h,),
                CommonAppInput(textEditingController: controller.descriptionController.value,
                  filledColor: AppColors.colorD9D9D9,
                  borderRadius: 0,
                  hintText: "Enter Description",
                  hintStyle: TextStyle(fontSize: 13.sp),
                ),
                SizedBox(height: 15.h,),
                GestureDetector(
                  onTap: () {
                    debugPrint("ad");
                    Utils.selectTime(context,
                        controller.startTime.value != "Select Time" ? controller
                            .startTimeValue.value : null).then((value) {
                      if (value != null) {
                        if(controller.isTimeValid(value,controller.startTimeValue.value) == false){
                          controller.startTime.value = "${value.hour.toString()
                              .padLeft(2, '0')}:${value.minute.toString().padLeft(
                              2, '0')}";
                          controller.startTimeValue.value = value;

                        }else {Utils.showMessage("You can not Previous time");}
                      }
                    });
                  },
                  child: Container(height: 45.h, width: Get.width,
                      decoration:  BoxDecoration(
                          color: AppColors.colorD9D9D9,
                        borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(children: [
                        SizedBox(width: 10.w,),
                        CommonMontserratText(text: controller.startTime.value,
                          textSize: 12.sp,
                          color: AppColors.colorBlack.withOpacity(0.6),)
                      ],)),),
//
                SizedBox(height: 50.h,),
                CommonAppButton(text: "Add Item", onClick: (){
                 if(controller.checkValidations()){

                   if(StorageManager().getTimerData()!=null){
                     List? storedList = StorageManager().getTimerData();
                     storedList!.add({"title":controller.titleController.value.text.trim().toString(),"description":controller.descriptionController.value.text.trim().toString(),"selectedTime":controller.startTime.value});
                     StorageManager().setTimerData(storedList);

                   }else {
                     StorageManager().setTimerData([{"title":controller.titleController.value.text.trim().toString(),"description":controller.descriptionController.value.text.trim().toString(),"selectedTime":controller.startTime.value}]);
                   }
                   Get.back(result: {"title":controller.titleController.value.text.trim().toString(),"description":controller.descriptionController.value.text.trim().toString(),"selectedTime":controller.startTime.value});


                 }

                },height: 48.h,borderRadius: 10.r,)

              ],),
            ),
          ),
        ),
      );
    });
  }
}
