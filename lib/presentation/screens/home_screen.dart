import 'package:flutter/material.dart';
import 'package:tms_app/presentation/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Home'),
      ),
      body: const Center(
        child: Text('Home'),
      ),
      drawer: const AppDrawer(),
    );
  }
}