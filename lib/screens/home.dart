import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../navigation/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var currentUser = _authService.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.login, (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration in the center
            Image.asset(
              'assets/images/welcome.png', // Replace with your asset's path
              height: 200, // Adjust height as needed
              width: 200, // Adjust width as needed
            ),
            SizedBox(height: 20), // Space between the image and the text

            // Greeting text
            Text(
              'Welcome, ${currentUser?.displayName ?? 'Guest'}!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24, // Larger font size for emphasis
                fontWeight: FontWeight.bold, // Bold text
                color: Colors.pink, // Attractive font color
              ),
            ),
            SizedBox(height: 10),

            // Subtext (Optional)
            Text(
              'We hope you have a great experience!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic, // Italic for a softer feel
                color: Colors.grey[600], // Subtle color for secondary text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
