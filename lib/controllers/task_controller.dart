import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_app/controllers/auth_controller.dart';
import 'package:tms_app/models/category_model.dart';
import 'package:tms_app/routes/app_routes.dart';
import 'package:tms_app/utils/helpers.dart';

class TaskController extends GetxController {

  var isLoading = false.obs;
  var error     = ''.obs;
  var tasks     = [].obs;
  var count     = 0.obs;
  var getId     = ''.obs;

  final AuthController _authController              = Get.find<AuthController>();
  final ApiService _apiService                      = ApiService();
  final Rx<DateTime?> selectedDate                  = Rx<DateTime?>(null);
  final GlobalKey<FormState> formKey                = GlobalKey<FormState>();
  final TextEditingController nameController        = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var categories        = <CategoryTask>[];
  var selectedCategory  = Rx<CategoryTask?>(null);

  List<String> priority         = ['Low', 'Medium', 'High'];
  Rx<String?> selectedPriority  = Rx<String?>(null);

  List<String> status           = ['To do', 'In Progress', 'Done'];
  Rx<String?> selectedStatus    = Rx<String?>(null);

  @override
  void onInit(){
    super.onInit();
      Future.wait([
          
          // Add a delay of 2 seconds before executing loadToken
          Future.delayed(const Duration(seconds: 2), () => loadToken()),
          // Add a delay of 1 second before executing getAll
          Future.delayed(const Duration(seconds: 1), () => getAll()),
          // Add a delay of 3 seconds before executing getCategories
          Future.delayed(const Duration(seconds: 3), () => getCategories()),
      ]);
  }


  Future loadToken() async {
    await _authController.loadAuthToken();
  }

   String? validateName(String? value){
    if(value == null || value.isEmpty){
      return "Name must be filled!";
    }
    return null;
  }

   String? validateDescription(String? value){
    if(value == null || value.isEmpty){
      return "Description must be filled!";
    }
    return null;
  }

  Future<void> getAll() async {
    try {

      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2));
      final response = await _apiService.get('task', _authController.authToken.value);

      if (response.statusCode == 200) {
        
        final responseData        = jsonDecode(response.body)['data'];

        if (responseData.length <= 0) {
          error.value = "There is no data at the moment!";
        }

        tasks.value = responseData;

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

  Future<void> store() async {
    try {
      
      final name         = nameController.text;
      final description  = descriptionController.text;
      isLoading.value = true;
      
      if (name.isNotEmpty && description.isNotEmpty) {
        final Map<String, dynamic> data = {
          'title' : name,
          'description' : description,
          'category_id' : selectedCategory.value?.id.toString(),
          'priority' : selectedPriority.value,
          'status'   : selectedStatus.value,
          'due_date' : selectedDate.toString()
        };

        await Future.delayed(const Duration(seconds: 2));
        final response = await _apiService.post('task', jsonEncode(data), _authController.authToken.value);

        if (response.statusCode == 200){
          Get.snackbar('Success', 'Create Task!');
          Get.offAllNamed(AppRoutes.home);
        } else {
          final responseData = jsonDecode(response.body);
          error.value = responseData['message'];
          Get.snackbar('Error', error.value);
        }
      }
      
    } catch (e) {
      error.value = 'An error occured. Please check your internet connection.';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> put(String taskId) async{
    try {

      final name         = nameController.text;
      final description  = descriptionController.text;
      isLoading.value = true;

       final Map<String, dynamic> data = {
          'title' : name,
          'description' : description,
          'category_id' : selectedCategory.value?.id.toString(),
          'priority' : selectedPriority.value,
          'status'   : selectedStatus.value,
          'due_date' : selectedDate.toString()
        };

      await Future.delayed(const Duration(seconds: 2));
      final response = await _apiService.update('task/${getId.value}', jsonEncode(data), _authController.authToken.value);
      
      if (response.statusCode == 200){
          Get.snackbar('Success', 'Update Task!');
          Get.offAllNamed(AppRoutes.home);
        } else {
          final responseData = jsonDecode(response.body);
          error.value = responseData['message'];
          Get.snackbar('Error', error.value);
      }
      
    } catch (e) {
      error.value = 'An error occured. Please check your internet connection.';
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> delete(int? id) async {
    try {

      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2));
      final response = await _apiService.delete('task/$id', _authController.authToken.value);
      
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Delete Task!');
        Get.offAllNamed(AppRoutes.home);
      } else {
        final responseData = jsonDecode(response.body);
        error.value = responseData['message'];
        Get.snackbar('Error', error.value);
      }
      
    } catch (e) {
      error.value = 'An error occured. Please check your internet connection.';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCategories() async {
    try { 

      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      final response = await _apiService.get('categories', _authController.authToken.value);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<dynamic> datas =  responseData['data'];

        if (datas.isEmpty) {
          error.value = "There is no data at the moment!";
        }

        count.value  = datas.length;
        
        List<CategoryTask> categoriesList = datas.map((e) => CategoryTask.fromJson(e)).toList();
        categories.assignAll(categoriesList);
        
      }else{
        error.value = "An error occured while fetching Categories!";
        Get.snackbar('Error', error.value);
      }
      
    } catch (e) {
      categories.clear();
      error.value = 'An error occured. Please check your internet connection.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastDate = currentDate.add(const Duration(days: 365 * 10));

    DateTime? pickedDate = await showDatePicker(
      context: context, 
      initialDate: currentDate, 
      firstDate: currentDate, 
      lastDate: lastDate
    );
    
    if(pickedDate != null){
      selectedDate.value = pickedDate;
      update();
    }
  }
}