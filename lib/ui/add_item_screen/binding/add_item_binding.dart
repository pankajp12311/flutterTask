import 'package:fluttertask/ui/add_item_screen/view/add_item_controller.dart';
import 'package:get/get.dart';

class AddItemBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => AddItemController());
  }

}