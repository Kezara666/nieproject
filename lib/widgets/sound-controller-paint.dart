import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nieproject/utils/colors.dart';

class SoundControllerPainter extends CustomPainter {
  final double volume;

  SoundControllerPainter(this.volume);

  @override
  void paint(Canvas canvas, Size size) {
    // Define the center and radius of the circle
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2.5;

    // Define the linear gradient colors
    final gradient = const LinearGradient(
      colors: playerVolumeSmallBall,
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    // Draw the outer circle
    Paint outerCirclePaint = Paint()
      ..color =  playerVolumeOuterCircle// Make the outer circle transparent for testing
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    canvas.drawCircle(center, radius+10, outerCirclePaint);

    // Calculate the angle based on the current volume
    //double angle = 2 * volume * 3.1416;

    // Draw the volume arc with linear gradient
    // Paint volumeArcPaint = Paint()
    //   ..shader = gradient // Use the linear gradient for the volume arc color
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 15.0;

    // Calculate the start angle based on volume (making it start from the top)
    //double startAngle = -3.1416 / 2;

    // Draw the partial arc based on volume
    // canvas.drawArc(
    //   Rect.fromCircle(center: center, radius: radius - 15),
    //   startAngle,
    //   angle,
    //   false,
    //   volumeArcPaint,
    // );
    final Paint paint2 = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.width / 2;
    final double xOffset = centerX - radius * cos(pi * volume*1.5)*0.7;
    final double yOffset = centerY - radius * sin(pi * volume*1.5)*0.7;

    canvas.drawCircle(Offset(xOffset, yOffset),15, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
