import 'package:flutter/material.dart';
import 'dart:math' as math;

class HabitCanvasProgress extends StatelessWidget {
  final double progress; // Valor entre 0.0 y 1.0

  const HabitCanvasProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        painter: ProgressPainter(progress: progress),
        child: Center(
          child: Text(
            '${(progress * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.teal.shade100
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2) - 10;

    // Dibujar círculo de fondo
    canvas.drawCircle(center, radius, backgroundPaint);

    // Dibujar arco de progreso
    double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  late Offset center;

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
