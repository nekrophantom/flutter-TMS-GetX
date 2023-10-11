import 'package:get/get.dart';
import 'package:tms_app/bindings/auth_binding.dart';
import 'package:tms_app/bindings/task_binding.dart';
import 'package:tms_app/presentation/screens/auth/register_screen.dart';
import 'package:tms_app/presentation/screens/home_screen.dart';
import 'package:tms_app/presentation/screens/task/create_screen.dart';
import 'package:tms_app/presentation/screens/task/edit_screen.dart';
import 'package:tms_app/routes/app_routes.dart';

import '../presentation/screens/auth/login_screen.dart';

class AppPages{

  static final pages = [
    GetPage(
      name: AppRoutes.login, 
      page: () => const LoginScreen(),
      binding: AuthBinding()
    ),
    GetPage(
      name: AppRoutes.home, 
      page: () => const HomeScreen(),
      binding: TaskBinding()
    ),
    GetPage(
      name: AppRoutes.createTask, 
      page: () => const CreateTaskScreen(),
      binding: TaskBinding(),
      
    ),
    GetPage(
      name: AppRoutes.register, 
      page: () => const RegisterScreen(),
      binding: AuthBinding()
    ),
    GetPage(
      name: AppRoutes.editTask,
      page: () => EditTaskScreen(),
      binding: TaskBinding()
    )
  ];

}