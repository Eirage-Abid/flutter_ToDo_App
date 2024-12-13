import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// corrected code
// When using a StatelessWidget, the build method must return a widget
  class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  body: Center(
  child: LoadingAnimationWidget.twistingDots(
  leftDotColor: const Color(0xFF1A1A3F),
  rightDotColor: const Color(0xFFEA3799),
  size: 80,
  ),
  ),
  );
  }
  }

  //Troubled code

// When using a StatelessWidget, the build method must return a widget
/** Widget build(BuildContext context) {
    /** return Container(
    color: Colors.black.withOpacity(0.5), // Semi-transparent background
    child: Center(
    child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
    ),
    ),**/
    Scaffold(
    body: Center(
    child: LoadingAnimationWidget.twistingDots(
    leftDotColor: const Color(0xFF1A1A3F),
    rightDotColor: const Color(0xFFEA3799),
    size: 200,
    ),
    ),
    );
    }
    }**/
