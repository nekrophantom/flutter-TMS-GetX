import 'package:get/get.dart';
import 'package:tms_app/controllers/auth_controller.dart';

class AuthBinding implements Bindings{
 
  @override
  void dependencies(){
    Get.lazyPut(() => AuthController());
  }
}