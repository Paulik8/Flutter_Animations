import 'dart:math';

import 'package:flutter/material.dart';

import '../duration_data.dart';
import '../widgets/showcase_scaffold.dart';

class WavesShowcase extends StatefulWidget {
  static const title = 'WavesShowcase';

  const WavesShowcase({Key? key}) : super(key: key);

  @override
  State<WavesShowcase> createState() => _WavesShowcaseState();
}

class _WavesShowcaseState extends State<WavesShowcase>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DurationData.of(context)?.duration;
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) => ShowcaseScaffold(
        WavesShowcase.title,
        useSafeArea: false,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return CustomPaint(
                size: const Size(double.infinity, 400),
                painter: _WavePainter(
                  animationValue: _controller.value,
                  waveColor: Colors.blue,
                ),
              );
            },
          ),
        ),
      );

  // @override
  // Widget build(BuildContext context) => ShowcaseScaffold(
  //       WavesShowcase.title,
  //       useSafeArea: false,
  //       body: Align(
  //         alignment: Alignment.bottomCenter,
  //         child: CustomPaint(
  //           size: const Size(double.infinity, 400),
  //           painter: _WavePainter(
  //             animation: _controller,
  //             // animationValue: _controller.value,
  //             waveColor: Colors.blue,
  //           ),
  //         ),
  //       ),
  //     );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _WavePainter extends CustomPainter {
  static const _pi2 = 2 * pi;

  final Color waveColor;

  final double animationValue;

  // final Animation<double> animation;

  _WavePainter({
    required this.animationValue,
    required this.waveColor,
    // required this.animation,
  });

  // : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();
    for (var i = 0.0; i < width; i++) {
      path.lineTo(i, 0.0 - sin(_pi2 * (i / width + animationValue)) * 6);
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
