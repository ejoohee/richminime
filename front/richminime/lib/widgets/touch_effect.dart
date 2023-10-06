import 'package:flutter/material.dart';

class TouchEffect extends StatefulWidget {
  final Widget child;

  const TouchEffect({required this.child, Key? key}) : super(key: key);

  @override
  TouchEffectState createState() => TouchEffectState();
}

class TouchEffectState extends State<TouchEffect> {
  Offset? touchPosition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child, // 자식 위젯을 먼저 그립니다.

        if (touchPosition != null)
          CustomPaint(
            painter: TouchEffectPainter(touchPosition),
          ), // 터치 효과를 그립니다.

        // 터치 이벤트를 감지하는 위젯
        Positioned.fill(
          child: GestureDetector(
            onTapDown: (details) {
              setState(() {
                touchPosition = details.localPosition;
              });
            },
          ),
        ),
      ],
    );
  }
}

class TouchEffectPainter extends CustomPainter {
  final Offset? touchPosition;

  TouchEffectPainter(this.touchPosition);

  @override
  void paint(Canvas canvas, Size size) {
    if (touchPosition != null) {
      final paint = Paint()
        ..color = Colors.blue.withOpacity(0.3)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(touchPosition!, 25, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
