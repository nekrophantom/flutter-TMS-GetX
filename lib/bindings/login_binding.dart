import 'package:get/get.dart';
import 'package:tms_app/controllers/auth_controller.dart';

class LoginBinding implements Bindings{
 
  @override
  void dependencies(){
    Get.lazyPut(() => AuthController());
  }
}