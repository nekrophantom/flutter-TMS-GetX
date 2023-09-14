import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_app/controllers/task_controller.dart';
import 'package:tms_app/models/category_model.dart';
import 'package:tms_app/utils/helpers.dart';

class CreateTask extends GetView<TaskController>{
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new Task!'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
      

                DropdownButtonFormField<CategoryTask>(
                  value: controller.selectedCategory.value,
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
                  onChanged: controller.selectedCategory,
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name')
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
                  value: controller.selectedPriority.value,
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
                
                 DropdownButtonFormField(
                  value: controller.selectedStatus.value,
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
                        controller.selectedDate == null ? 'Due date : ' : 'Due Date : ${DateFormat('E, dd MMM yyyy').format(controller.selectedDate!)}',
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

                ElevatedButton(
                  onPressed: controller.isLoading.isTrue ? null : () async {
                    if(controller.formKey.currentState!.validate()){
                      await controller.store();
                    }
                  }, 
                  child: controller.isLoading.isTrue ? const Center(child: CircularProgressIndicator(),) :  const Text('Submit')
                )
      
              ],
            )
          ),
        ),
      ),
    );
  }
}