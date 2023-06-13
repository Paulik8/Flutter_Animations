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
    duration: Duration.zero,
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
        body:
            Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.green,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  size: const Size(double.infinity, 800),
                  painter: _WavePainter(
                    animationValue: _controller.value,
                    boxHeight: 200,
                    waveColor: Colors.blue,
                  ),
                );
              },
            ),
          ),
        ),
      );

  // @override
  // Widget build(BuildContext context) => ShowcaseScaffold(
  //       WavesShowcase.title,
  //       body: SizedBox(
  //         height: 500,
  //         width: 500,
  //         child: CustomPaint(
  //           painter: _WavePainter(
  //             animation: _controller,
  //             boxHeight: 300,
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

  final double boxHeight;
  final Color waveColor;

  final double animationValue;

  // final Animation<double> animation;

  _WavePainter({
    required this.animationValue,
    required this.boxHeight,
    required this.waveColor,
    // required this.animation,
  });

  // : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final baseHeight = boxHeight;

    final width = size.width;
    final height = size.height - 100;
    final path = Path();
    // path.moveTo(0.0, height);
    for (var i = 0.0; i < width; i++) {
      path.lineTo(i, 0 - sin(_pi2 * (i / width + animationValue)) * 6);
    }

    path.lineTo(width, height);
    path.lineTo(0.0, height);
    // path.moveTo(0.0, baseHeight);
    // for (var i = 0.0; i < width; i++) {
    //   path.lineTo(i, baseHeight + sin(_pi2 * (i / width + animationValue)) * 6);
    // }
    //
    // path.lineTo(width, height);
    // path.lineTo(0.0, height);
    path.close();
    final wavePaint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
