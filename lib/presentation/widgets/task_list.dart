import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_app/controllers/task_controller.dart';
import 'package:tms_app/routes/app_routes.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();
    
    Widget buildLoadingWidget() {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: taskController.tasks.length,
      itemBuilder: (context, index) {
        
        if(index < 0 || index >= taskController.tasks.length){
          return Container();
        }

        final task = taskController.tasks[index];
        final DateFormat dateFormat = DateFormat('EE, dd MMM yyyy');
        final taskDueDate = DateTime.parse(task['due_date']);  
        
        if (taskController.tasks.isEmpty){
          return buildLoadingWidget();
        }

        void handleMenuItemSelected(String value) {
          if(value == 'edit'){
              Get.toNamed(
                AppRoutes.editTask, 
                parameters: {
                  'id' : task['id'].toString(),
                  'categoryName' : task['categoryName'],
                  'title' : task['title'].toString(),
                  'description' : task['description'].toString(),
                  'due_date' : task['due_date'],
                  'priority' : task['priority'],
                  'status' : task['status']
                }
              );
          
          } else if (value == 'delete'){

            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return Obx(() {
                  final isLoading = taskController.isLoading.value;

                  if(isLoading){
                    return const CircularProgressIndicator();
                  } else {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: Text("Are you sure you want to delete ${task['title']}"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          }, 
                          child: const Text('Cancel')
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            
                            await taskController.delete(task['id']);
                          }, 
                          child: const Text('Delete')
                        )
                      ],
                    );
                  }
                });
              },
            );
          }
        }

        return Container(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 4,
            color: Colors.grey[200],
            child: ListTile(
              title: Text(task['title'].toString()),
              subtitle: Text('Due date : ${dateFormat.format(taskDueDate)}'),
              trailing: PopupMenuButton<String>(
                onSelected: handleMenuItemSelected,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title:  Text('Edit'),
                    )
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title:  Text('Delete'),
                    )
                  ),
                ]
              ),
              leading: Container(alignment: Alignment.center, width: 50, child: getIcon(task['categoryName']),),
            ),
          ),
        );
      },
    );
  }
}

FaIcon getIcon(categoryName) {
  switch (categoryName){
    case 'Personal':
      return const FaIcon(FontAwesomeIcons.person);
    case 'Work':
      return const FaIcon(FontAwesomeIcons.briefcase);
    case 'Home':
      return const FaIcon(FontAwesomeIcons.house);
    case 'Health and Fitness':
      return const FaIcon(FontAwesomeIcons.heartPulse);
    case 'Study':
      return const FaIcon(FontAwesomeIcons.book);
    case 'Social':
      return const FaIcon(FontAwesomeIcons.users);
    case 'Errands':
      return const FaIcon(FontAwesomeIcons.cartShopping);
    case 'Travel':
      return const FaIcon(FontAwesomeIcons.plane);
    case 'Financial':
      return const FaIcon(FontAwesomeIcons.moneyBill);
    default:
      return const FaIcon(FontAwesomeIcons.spinner);
  }
}