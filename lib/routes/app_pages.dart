import 'package:get/get.dart';
import 'package:tms_app/bindings/login_binding.dart';
import 'package:tms_app/bindings/task_binding.dart';
import 'package:tms_app/presentation/screens/home_screen.dart';
import 'package:tms_app/routes/app_routes.dart';

import '../presentation/screens/auth/login_screen.dart';

class AppPages{

  static final pages = [
    GetPage(
      name: AppRoutes.login, 
      page: () => const LoginScreen(),
      binding: LoginBinding()
    ),
    GetPage(
      name: AppRoutes.home, 
      page: () => const HomeScreen(),
      binding: TaskBinding()
    )
  ];

}