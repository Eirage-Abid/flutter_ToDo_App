import 'package:flutter/material.dart';
import '../navigation/app_routes.dart'; // Import your app's routes for navigation

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Illustration at the top
              Expanded(
                flex: 6,
                child: Image.asset(
                  'assets/images/todo.png', // Replace with your asset path
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // App title and description
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Text(
                      "Flutter To-Do App",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "A digital tool that helps you organize your tasks and keep track.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Login and Register buttons
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Sign-in',
                          style: TextStyle(fontSize: 18),

                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signup);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Sign-up',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
