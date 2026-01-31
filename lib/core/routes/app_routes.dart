import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:flutter_todolist_app/features/add_edit_task/binging/add_edit_task_binding.dart';
import 'package:flutter_todolist_app/features/add_edit_task/view/add_edit_task_page.dart';
import 'package:flutter_todolist_app/features/home/bindings/home_binding.dart';
import 'package:flutter_todolist_app/features/home/view/home_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(
      name: RouteNames.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteNames.addEditTask,
      page: () => const AddEditTaskPage(),
      binding: AddEditTaskBinding(),
    ),
  ];
}
