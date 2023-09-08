import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_app/controllers/task_controller.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();
    return ListView.builder(
      itemCount: taskController.count,
      itemBuilder: (context, index) {
        final task = taskController.tasks[index];
        final DateFormat dateFormat = DateFormat('EEEE, dd MMM yyyy');
        return Container(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 4,
            color: Colors.grey[200],
            child: ListTile(
              title: Text(task.title.toString()),
              subtitle: Text('Due date : ${dateFormat.format(task.dueDate)}'),
              trailing: IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.bars)),
              leading: Container(alignment: Alignment.center, width: 50, child: getIcon(task.categoryName),),
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