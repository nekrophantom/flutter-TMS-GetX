import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms_app/controllers/auth_controller.dart';
import 'package:tms_app/presentation/widgets/auth_rich_text.dart';
import 'package:tms_app/routes/app_routes.dart';
import 'package:tms_app/utils/constant.dart';
import 'package:tms_app/utils/helpers.dart';


class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

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
                    AppImages.personAdd,
                    height: ResponsiveHelper.screenHeight(context, 0.2),
                  ),
                
                  SizedBox(height: ResponsiveHelper.screenHeight(context, 0.05),),
        
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [

                          // Name Text Field
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.nameController,
                            validator: controller.validateName,
                            decoration: const InputDecoration(
                              label: Text('Name'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
        
                          SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),
                          
        
                          // Email Text Field
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
        
                          // Password Text Field
                          TextFormField(
                            controller: controller.passwordController,
                            validator: controller.validatePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Password'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
        
                          SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),
        
                          // Confirm Password
                          TextFormField(
                            controller: controller.confirmPasswordController,
                            validator: controller.validateConfirmPassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Confirm Password'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),

                          SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.isTrue ? null : () async {
                              if(controller.formKey.currentState!.validate()){
                                await controller.register();
                              }
                            }, 
                              child: controller.isLoading.isTrue ? const Center(child: CircularProgressIndicator(color: Colors.blue,)) : const Text('Submit')
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                  
                AuthRichText(
                  title: "Already have an account? ", 
                  link: "Sign in.", 
                  onTap: () => Get.offAllNamed(AppRoutes.login)
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}