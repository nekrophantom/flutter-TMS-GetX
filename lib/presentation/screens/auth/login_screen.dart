import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tms_app/controllers/auth_controller.dart';
import 'package:tms_app/presentation/widgets/auth_rich_text.dart';
import 'package:tms_app/routes/app_routes.dart';
import 'package:tms_app/utils/constant.dart';
import 'package:tms_app/utils/helpers.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: ResponsiveHelper.screenHeight(context, 0.05),),
        
                SvgPicture.asset(
                  AppImages.lock,
                  height: ResponsiveHelper.screenHeight(context, 0.2),
                ),
              
                SizedBox(height: ResponsiveHelper.screenHeight(context, 0.05),),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
        
                        // Email Field
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.emailController,
                          validator: controller.validateEmail,
                          decoration: const InputDecoration(
                            label: Text('Email'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
        
                        SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),
        
                        // Password Field
                        TextFormField(
                          obscureText: true,
                          controller: controller.passwordController,
                          validator: controller.validatePassword,
                          decoration: const InputDecoration(
                            label: Text('Password'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
        
                        SizedBox(height: ResponsiveHelper.screenHeight(context, 0.05),),
        
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.isTrue ? null : () async {
                              if(controller.formKey.currentState!.validate()){
                                await controller.login();
                              }
                            } , 
                            child: controller.isLoading.isTrue ? const Center(child: CircularProgressIndicator(color: Colors.blue,)) : const Text('Sign in')
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015)),

                AuthRichText(
                  title: "Don't have an account? ", 
                  link: "Register here.", 
                  onTap: () => Get.offAllNamed(AppRoutes.register)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}