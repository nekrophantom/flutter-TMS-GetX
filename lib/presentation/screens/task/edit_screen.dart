import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_app/controllers/task_controller.dart';
import 'package:tms_app/models/category_model.dart';
import 'package:tms_app/utils/helpers.dart';

class EditTaskScreen extends GetView<TaskController>{
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final task = Get.parameters;
    controller.getId.value = task['id']!;
    controller.nameController.text = task['title']!;
    controller.descriptionController.text = task['description']!;
    controller.selectedCategory.value ??= controller.categories.firstWhere((element) => element.name == task['categoryName'],);
    controller.selectedPriority.value ??= task['priority'];
    controller.selectedStatus.value ??= task['status'];
    controller.selectedDate.value = DateTime.parse(task['due_date']!);
    
    return WillPopScope(
      onWillPop: () async {
        controller.nameController.clear();
        controller.descriptionController.clear();
        controller.selectedCategory.value = null;
        controller.selectedPriority.value = null;
        controller.selectedStatus.value = null;
        controller.selectedDate.value = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Task!'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
    
                  DropdownButtonFormField<CategoryTask>(
                    value: controller.selectedCategory.value ?? 
                    controller.categories.firstWhere(
                      (element) => element.name == task['categoryName'],
                    ),
                    items: [
                      const DropdownMenuItem<CategoryTask>(
                        value: null,
                        child: Text('Select a Category')
                      ),
                      for (CategoryTask category in controller.categories)
                        DropdownMenuItem(
                          value: category,
                          child: Text(category.name)
                      ),
                    ], 
                    onChanged: (newValue) {
                      controller.selectedCategory.value = newValue;
                    },
                     decoration: const InputDecoration(
                      label: Text('Category'),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value == null){
                        return 'Please select a category!';
                      }
                      return null;
                    },
                  ),
        
                  SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),
        
                  TextFormField(
                    controller: controller.nameController,
                    onChanged: (newValue){
                      controller.nameController.text = newValue;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Title')
                    ),
                    validator: controller.validateName,
                  ),
        
                  SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),
        
                  TextFormField(
                    controller: controller.descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Description')
                    ),
                    maxLines: 4,
                    validator: controller.validateDescription,
                  ),
        
                  SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),
                  
                   DropdownButtonFormField<String>(
                    value: task['priority'],
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Select Priority'),
                      ),
                      for (String priority in controller.priority)
                        DropdownMenuItem(
                          value: priority,
                          child: Text(priority)
                      )
                    ], 
                    onChanged: controller.selectedPriority,
                    decoration: const InputDecoration(
                      label: Text('Priority'),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value == null){
                        return 'Please select a Priority!';
                      }
                      return null;
                    },
                  ),
        
                  SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),
                  
                  DropdownButtonFormField<String>(
                    value: task['status'],
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Select Status'),
                      ),
                      for (String status in controller.status)
                        DropdownMenuItem(
                          value: status,
                          child: Text(status)
                      )
                    ],
                    onChanged: controller.selectedStatus,
                    decoration: const InputDecoration(
                      label: Text('Status'),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value == null){
                        return 'Please select a Status!';
                      }
                      return null;
                    },
                  ),
        
                  SizedBox(height: ResponsiveHelper.screenHeight(context, 0.015),),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Obx(() {
                        return Text(
                          task['due_date'] != null && controller.selectedDate.value == null 
                          ? 'Due Date : ${DateFormat('E, dd MMM yyyy').format(DateTime.parse(task['due_date']!))}' 
                          : 'Due Date : ${DateFormat('E, dd MMM yyyy').format(controller.selectedDate.value as DateTime)}',
                          style: const TextStyle(
                            fontSize: 18
                          ),
                        );
                      }),
                      
                      ElevatedButton(
                        onPressed: () {
                          controller.selectDate(context);
                        }, 
                        child: const Text('Choose Date')
                      )
                    ],
                  ),
    
                  SizedBox(height: ResponsiveHelper.screenHeight(context, 0.025),),
    
                  Obx(() {
                    return controller.isLoading.value 
                    ? const CircularProgressIndicator() 
                    : ElevatedButton(
                      onPressed: controller.isLoading.value ? null : () async {
                        if(controller.formKey.currentState!.validate()){
                          await controller.put(task['id']!);
                        }
                      }, 
                      child: const Text('Submit')
                    );  
                  })
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}