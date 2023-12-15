import 'dart:math';

import 'package:flutter/material.dart';

class AudioWaveAnimation extends StatefulWidget {
  @override
  _AudioWaveAnimationState createState() => _AudioWaveAnimationState();
}

class _AudioWaveAnimationState extends State<AudioWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: AudioWavePainter(_animation.value),
        size: Size(200, 100),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AudioWavePainter extends CustomPainter {
  final double animationValue;

  AudioWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double centerY = size.height / 2;
    final double amplitude = size.height * 0.3;
    final double frequency = 2 * pi / size.width;

    Path path = Path();

    for (double x = 0; x <= size.width; x++) {
      final double y = sin(frequency * x + animationValue) * amplitude + centerY;
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}