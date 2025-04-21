// Custom Clipper for Curved AppBar

import 'package:flutter/material.dart';

class TAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-40);

    // First curve (bottom-left)
    final firstCurveStart = Offset(0, size.height - 20); 
    final firstCurveEnd = Offset(30,  size.height - 20);
    path.quadraticBezierTo(firstCurveStart.dx, firstCurveStart.dy, firstCurveEnd.dx, firstCurveEnd.dy);

    // Straight line between curves
    final secondCurveStart = Offset(0 , size.height - 20); // Start where first curve ended
    final secondCurveEnd = Offset(size.width - 30, size.height - 20); // End before the second curve starts
    path.lineTo(secondCurveStart.dx, secondCurveStart.dy); // Add this line explicitly
    path.lineTo(secondCurveEnd.dx, secondCurveEnd.dy);

    // Second curve (bottom-right)
    final thirdCurveStart = Offset(size.width, size.height - 20); 
    final thirdCurveEnd = Offset(size.width, size.height); // End at bottom-right corner
    path.quadraticBezierTo(thirdCurveStart.dx, thirdCurveStart.dy, thirdCurveEnd.dx, thirdCurveEnd.dy);

    path.lineTo(size.width, 0); // Line to top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; // As per the image
  }
}
