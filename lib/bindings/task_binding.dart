import 'package:get/get.dart';
import 'package:tms_app/controllers/auth_controller.dart';
import 'package:tms_app/controllers/task_controller.dart';

class TaskBinding implements Bindings{
 
  @override
  void dependencies(){
    Get.lazyPut(() => TaskController());
    Get.lazyPut(() => AuthController());
  }
}