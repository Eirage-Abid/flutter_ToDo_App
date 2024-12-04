import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'todo_screen.dart'; // Replace with your actual home screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => ToDoScreen(), // Replace with your home screen
      },
    );
  }
}
