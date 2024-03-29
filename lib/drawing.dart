import 'package:flutter/material.dart';
import 'constant.dart';

final Paint kDrawingPaint = Paint()
  ..strokeCap = StrokeCap.round
  ..isAntiAlias = kIsAntiAlias
  ..color = kBlackBrushColor
  ..strokeWidth = kStrokeWidth;
class DrawingPainter extends CustomPainter {
  DrawingPainter({this.offsetPoints});
  List<Offset> offsetPoints;
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < offsetPoints.length - 1; i++) {
      if (offsetPoints[i] != null && offsetPoints[i + 1] != null) {
        canvas.drawLine(offsetPoints[i], offsetPoints[i + 1], kDrawingPaint);
      }
    }
  }
  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

