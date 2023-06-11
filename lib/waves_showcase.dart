import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WavesShowcase extends StatefulWidget {
  const WavesShowcase({Key? key}) : super(key: key);

  @override
  State<WavesShowcase> createState() => _WavesShowcaseState();
}

class _WavesShowcaseState extends State<WavesShowcase>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  // @override
  // Widget build(BuildContext context) {
  //   // ShaderMask
  //   return Scaffold(
  //     body: SizedBox(
  //       height: 500,
  //       width: 500,
  //       child: AnimatedBuilder(
  //         animation: _controller,
  //         builder: (BuildContext context, Widget? child) {
  //           return CustomPaint(
  //             painter: _WavePainter(
  //               animationValue: _controller.value,
  //               boxHeight: 300,
  //               waveColor: Colors.blue,
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // ShaderMask
    return SizedBox(
      height: 500,
      width: 500,
      child: CustomPaint(
        painter: _WavePainter(
          animation: _controller,
          boxHeight: 300,
          waveColor: Colors.blue,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _WavePainter extends CustomPainter {
  static const _pi2 = 2 * pi;

  // final double animationValue;
  final double boxHeight;
  final Color waveColor;

  final Animation<double> animation;

  _WavePainter({
    // required this.animationValue,
    required this.boxHeight,
    required this.waveColor,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final baseHeight = boxHeight;

    final width = size.width;
    final height = size.height;
    final path = Path();
    path.moveTo(0.0, baseHeight);
    for (var i = 0.0; i < width; i++) {
      path.lineTo(i, baseHeight + sin(_pi2 * (i / width + animation.value)) * 6);
    }

    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();
    final wavePaint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
