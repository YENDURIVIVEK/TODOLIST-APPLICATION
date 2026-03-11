import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_task_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task Manager",

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      initialRoute: "/",

      routes: {
        "/": (context) => const SplashScreen(),
        "/auth": (context) => const AuthScreen(),
        "/dashboard": (context) => const DashboardScreen(),
        "/addTask": (context) => const AddTaskScreen(),
      },
    );
  }
}
