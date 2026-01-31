import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:flutter_todolist_app/features/home/view/home_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(name: RouteNames.home, page: () => const HomePage()),
  ];
}
