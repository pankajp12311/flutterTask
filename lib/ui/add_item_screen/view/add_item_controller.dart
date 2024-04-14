import 'package:flutter/material.dart';
import 'package:fluttertask/utility/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AddItemController extends GetxController{

  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  RxString startTime = "Select Time".obs;
  Rx<TimeOfDay> startTimeValue = TimeOfDay.now().obs;



  // this function is for checking time is previous or future

  bool isTimeValid(TimeOfDay pickedTime,TimeOfDay initialTime) {
    final dateTime = DateTime( DateTime.now().year, // Use the current year
      DateTime.now().month, // Use the current month
      DateTime.now().day,   // Use the current day
      pickedTime.hour,
      pickedTime.minute,);

    return dateTime.isBefore(DateTime( DateTime.now().year, // Use the current year
        DateTime.now().month, // Use the current month
        DateTime.now().day,   // Use the current day
        initialTime.hour,
        initialTime.minute));
  }

  /// Check title & description and Time validations as needed
  bool checkValidations() {
    if (titleController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter Title.");
      return false;
    } else if (descriptionController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter Description.");
      return false;
    } else if (startTime.value == "Select Time") {
      Utils.showMessage("Please select Time.");
      return false;
    }
    return true;
  }



}