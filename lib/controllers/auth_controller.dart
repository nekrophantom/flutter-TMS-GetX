import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tms_app/routes/app_routes.dart';

import '../utils/helpers.dart';
class AuthController extends GetxController{

  var isLoading       = false.obs;
  var error           = ''.obs;
  var authToken       = ''.obs;
  var isAuthenticated = false.obs; 

  final formKey                                   = GlobalKey<FormState>();
  final TextEditingController emailController     = TextEditingController();
  final TextEditingController passwordController  = TextEditingController();
  final ApiService _apiService                    = ApiService();

  String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return "Email must be filled!";
    }
    return null;
  }

  AuthController() {
    loadAuthToken();
  }

  String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Password must be filled!";
    }
    return null;
  }

  Future<void> login() async {
    
    try {
      final email     = emailController.text;
      final password  = passwordController.text;
      final data      = {'email' : email, 'password' : password};
      isLoading.value = true;

      // final response = await _apiService.post('login', data);
      final response = await http.post(_apiService.apiUrl('login'), body: data);
      final responseData = jsonDecode(response.body);
      saveAuthToken(responseData['data']['token']);

      if(formKey.currentState!.validate()){
        if(response.statusCode == 200){
          Get.offAllNamed(AppRoutes.home);
        }else{
          final responseData = jsonDecode(response.body);
          error.value = responseData['message'];
          Get.snackbar('Error', error.value);
        }
      }
      
    } catch (e) {
      error.value = 'An error occurred';
      Get.snackbar('Error', error.value);
    }finally{
      isLoading.value = false;
    }

  }

  Future<void> logout() async {
    try {

      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');

      final response = await http.post(
        _apiService.apiUrl('logout'),
        headers: {
          'Authorization' : 'Bearer ${authToken.value}'
      });

      authToken.value = '';

      if(response.statusCode == 200){
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar('Aww!', 'Please Come Back Again!');
      }else{
        Get.snackbar('Error', 'An error occured!');
      }
      
    } catch (e) {
      error.value = 'An error occurred';
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  void saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    authToken.value = token;
    isAuthenticated.value = true;
  }

  Future<void> loadAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken.value = prefs.getString('authToken') ?? '';
    isAuthenticated.value = authToken.isNotEmpty;
    update();
  }
}