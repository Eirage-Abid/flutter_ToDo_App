import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration
              Image.asset(
                'assets/todo_illustration.png', // Replace with your image asset
                height: 200, // Adjust height as needed
              ),
              const SizedBox(height: 20),
              // Description
              const Text(
                " Identify what's most important and focus on those tasks first!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              // Get Started Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.pushReplacementNamed(context, '/home'); // Update route as needed
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan, // Funky color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded button
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
