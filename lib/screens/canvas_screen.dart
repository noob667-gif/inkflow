import 'package:flutter/material.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Seite'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            color: Colors.white,
            width: 595, // A4 width in px @96dpi
            height: 842,
            child: Listener(
              onPointerDown: (event) {
                setState(() {
                  _points.add(event.localPosition);
                });
              },
              onPointerMove: (event) {
                setState(() {
                  _points.add(event.localPosition);
                });
              },
              onPointerUp: (_) {
                setState(() {
                  _points.add(Offset.zero);
                });
              },
              child: CustomPaint(
                painter: _SmoothPainter(_points),
                child: Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SmoothPainter extends CustomPainter {
  final List<Offset> points;

  _SmoothPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(_SmoothPainter oldDelegate) => true;
}
