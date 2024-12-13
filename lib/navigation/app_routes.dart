import 'package:flutter/material.dart';
import '../screens/sign_in.dart';
import '../screens/sign_up.dart';
import '../screens/home.dart';
import '../screens/forgot_password.dart'; // Import the ForgotPasswordScreen
import '../screens/begin_app.dart'; // Import the ForgotPasswordScreen


class AppRoutes {
  // Define all possible routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String forgotPassword = '/forgot-password'; // Add route constant
  static const String getStarted= '/getStart';

  static final Map<String, WidgetBuilder> routes = {
    // Other routes
    getStarted: (context) => GetStartedScreen(),
    // Map screens to their respective routes
    login: (context) => LoginScreen(),
    signup: (context) => SignupScreen(),
    home: (context) => HomeScreen(),
    forgotPassword: (context) => ForgotPasswordScreen(), // Add ForgotPasswordScreen
  };
}
