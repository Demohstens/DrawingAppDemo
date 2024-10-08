import 'package:sketchspace/canvas/canvas_context.dart';
import 'package:flutter/material.dart';

class ActivePainter extends CustomPainter {
  List<Offset> currentPath;
  Paint strokePaint;
  Mode mode;
  ActivePainter(this.currentPath, this.strokePaint, this.mode);

  @override
  void paint(Canvas canvas, Size size) {
    void drawLine() {
      if (currentPath.length < 2) return;

      canvas.drawLine(currentPath.first, currentPath.last, strokePaint);
    }

    void drawPath() {
      if (currentPath.isNotEmpty) {
        Paint paint = strokePaint;
        Path currentPathToDraw = Path();
        currentPathToDraw.moveTo(currentPath.first.dx, currentPath.first.dy);
        for (int i = 1; i < currentPath.length; i++) {
          currentPathToDraw.lineTo(currentPath[i].dx, currentPath[i].dy);
        }
        canvas.drawPath(currentPathToDraw, paint);
      }
    }

    switch (mode) {
      case Mode.drawing:
        drawPath();
      case Mode.erasing:
        drawPath();
      case Mode.line:
        drawLine();
      case Mode.fill:
        drawPath();
      case Mode.lifted || Mode.strokeErasing:
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
