import 'package:fluttertask/ui/dashboard/view/dashboard_controller.dart';
import 'package:get/get.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => DashboardController());

  }
}
