import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardsShowcaseNew extends StatelessWidget {
  const CardsShowcaseNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: List.generate(
          6,
          (index) => const AnimatedCardNew(),
        ),
      ),
    );
  }
}

class AnimatedCardNew extends StatefulWidget {
  const AnimatedCardNew({Key? key}) : super(key: key);

  @override
  State<AnimatedCardNew> createState() => _AnimatedCardNewState();
}

class _AnimatedCardNewState extends State<AnimatedCardNew>
    with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 2000);
  static const _collapsedHeight = 70.0;
  static const _expandedHeight = 120.0;
  static const _color = Colors.orange;
  static const _expandedText =
      'ewkgokweg[ewkgpwelgpkwgkewokgwegkwekgowegwegwegewlweflewpflwepflpwelfwelfpewlfwelfwelfewplfwlflwpwelfpwlpflpwefplwpelfpwe';

  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  );

  void _toggleCard() {
    switch (_controller.status) {
      case AnimationStatus.dismissed:
        _controller.forward();
        break;
      case AnimationStatus.forward:
        _controller.reverse();
        break;
      case AnimationStatus.reverse:
        _controller.forward();
        break;
      case AnimationStatus.completed:
        _controller.reverse();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Container(
          height: Tween(begin: _collapsedHeight, end: _expandedHeight)
              .evaluate(_controller),
          decoration: DecorationTween(
            begin: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: _color.withOpacity(0.4),
            ),
            end: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: _color,
            ),
          ).evaluate(_controller),
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('title'),
                    Transform.rotate(
                      angle: Tween(begin: 0.0, end: pi).evaluate(_controller),
                      child: SvgPicture.asset(
                        'assets/svg/arrow.svg',
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) =>
                        GradientTween().evaluate(_controller).createShader(
                              Rect.fromLTWH(
                                0,
                                0,
                                bounds.width,
                                bounds.height,
                              ),
                            ),
                    child: const Text(_expandedText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientTween extends Tween<LinearGradient> {
  @override
  LinearGradient get begin => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0],
        colors: [Colors.transparent],
      );

  @override
  LinearGradient get end => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [1.0],
        colors: [Colors.black],
      );

  @override
  LinearGradient lerp(double t) => LinearGradient.lerp(begin, end, t)!;
}
