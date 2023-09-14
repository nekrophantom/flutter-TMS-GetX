import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_app/controllers/task_controller.dart';
import 'package:tms_app/presentation/widgets/app_drawer.dart';
import 'package:tms_app/presentation/widgets/task_list.dart';
import 'package:tms_app/routes/app_routes.dart';

class HomeScreen extends GetView<TaskController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Home'),
        actions: [
          IconButton(
            onPressed: controller.getAll,
             icon: const Icon(Icons.refresh)
            )
        ],
      ),
      body: Center(
        child: Obx(() {
            if(controller.isLoading.value){
              return const Center(child: CircularProgressIndicator());  
            } else if(controller.error.value.isNotEmpty){
              return Text(controller.error.value);
            } else {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: TaskList(),
              );
            }
         }),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.createTask);
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}