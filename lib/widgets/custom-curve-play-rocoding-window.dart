import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nieproject/utils/colors.dart';


class CurvePainter extends CustomPainter {
  final double volume;
  final double screansize;

  CurvePainter(this.volume, this.screansize);

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    // Define the center and radius of the circle
    Offset center = Offset(size.width / 2, size.height*0.6); // Center of the canvas
    double radius = size.width / 2.5; // Adjust the radius as needed

    // Define the linear gradient colors
    final gradient = const LinearGradient(
      colors: playerVolumeSmallBall,
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    // Draw the outer circle
    

    final paintLow = Paint()
      ..color = playAvatar
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(
      center: center, // Center of the canvas
      radius: radius+(screansize/40),
    );

    // Define the start angle and sweep angle to create an arc
    final startAngle = -pi; // Start angle in radians (180 degrees)
    final sweepAngle = -pi * volume; // Sweep angle based on the volume

    // UseCenter should be false to create an arc instead of a full circle
    final useCenter = false;

    // Draw the arc within the circle
    
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    

    // Define the start angle and sweep angle to create an arc

    // Draw the arc within the circle
    canvas.drawArc(rect, startAngle, -pi*1, useCenter, paintLow);
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
    

    

    // Draw the image within the circle
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
