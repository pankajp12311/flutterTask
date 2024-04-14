import 'package:fluttertask/ui/add_item_screen/binding/add_item_binding.dart';
import 'package:fluttertask/ui/add_item_screen/view/add_item_screen.dart';
import 'package:fluttertask/ui/dashboard/view/dashboard_page.dart';
import 'package:get/get.dart';


import '../ui/dashboard/binding/dashboard_binding.dart';

/// All routes for app pages are defined here
class AppRoutes {

  static const dashboardPage = '/dashboard_page';
  static const addItemPage = '/add_item_page';

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.dashboardPage,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.addItemPage,
      page: () => const AddItemScreen(),
      binding: AddItemBinding(),
    ),
  ];
}
