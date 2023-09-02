import 'package:flutter/material.dart';
import 'package:tms_app/controllers/auth_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = AuthController();

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Welcome, '),
          ),
          
          const Divider(),

          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: controller.logout,
          )
        ],
      ),
    );
  }
}