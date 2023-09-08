import 'dart:convert';

import 'package:get/get.dart';
import 'package:tms_app/controllers/auth_controller.dart';
import 'package:tms_app/models/category_model.dart';
import 'package:tms_app/models/task_model.dart';
import 'package:tms_app/utils/helpers.dart';

class TaskController extends GetxController{

  var isLoading = false.obs;
  var error = ''.obs;
  final AuthController _authController = Get.find<AuthController>();
  final ApiService _apiService = ApiService();
  var tasks = <Task>[];
  var categories = <CategoryTask>[];
  var count = 0;

  @override
  void onInit(){
    super.onInit();
    _loadToken();
    getAll();
  }

  void _loadToken() {
    _authController.loadAuthToken();
  }

  Future<void> getAll() async {
    try {

      isLoading.value = true;
      final response = await _apiService.get('task', _authController.authToken.value);

      if (response.statusCode == 200) {
        
        final responseData = jsonDecode(response.body);
        final List<dynamic> datas =  responseData['data'];
        count  = datas.length;

        List<Task> taskList = datas.map((e) => Task.fromJson(e)).toList();
        tasks.assignAll(taskList);
        
      }else{
        error.value = "An error occured while fetching Task!";
        Get.snackbar('Error', error.value);
      }
      
    } catch (e) {
      tasks.clear();
      error.value = 'An error occured. Please check your internet connection.';
    }finally{
      isLoading.value = false;
    }
  }
}