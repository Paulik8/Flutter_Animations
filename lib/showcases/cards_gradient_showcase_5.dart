import 'dart:math';

import 'package:animations/duration_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/showcase_scaffold.dart';
import 'cards_showcase_1.dart';

class CardsGradientShowcase extends StatelessWidget {
  static const title = 'CardsGradientShowcase';

  const CardsGradientShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ShowcaseScaffold(
        CardsGradientShowcase.title,
        body: ListView(
          children: List.generate(
            6,
            (index) => const AnimatedCardNew(),
          ),
        ),
      );
}

class AnimatedCardNew extends StatefulWidget {
  const AnimatedCardNew({Key? key}) : super(key: key);

  @override
  State<AnimatedCardNew> createState() => _AnimatedCardNewState();
}

class _AnimatedCardNewState extends State<AnimatedCardNew>
    with SingleTickerProviderStateMixin {
  static const _collapsedHeight = 70.0;
  static const _expandedHeight = 120.0;
  static const _color = Colors.orange;

  late final _controller = AnimationController(vsync: this);

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DurationData.of(context)?.duration;
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
                    const Text('Card Title'),
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
                  child: Opacity(
                    opacity: Tween(begin: 0.0, end: 1.0).evaluate(_controller),
                    child: const Text(placeholderText),
                  ),
                ),
                // Expanded(
                //   child: ShaderMask(
                //     blendMode: BlendMode.srcIn,
                //     shaderCallback: (bounds) =>
                //         GradientTween().evaluate(_controller).createShader(
                //               Rect.fromLTWH(
                //                 0,
                //                 0,
                //                 bounds.width,
                //                 bounds.height,
                //               ),
                //             ),
                //     child: const Text(placeholderText),
                //   ),
                // ),
              ],
            ),
          ),
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

class GradientTween extends Tween<LinearGradient> {
  @override
  LinearGradient get begin => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.0, 0.0],
        colors: [
          Colors.black,
          Colors.black,
          Colors.transparent,
        ],
      );

  @override
  LinearGradient get end => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [1.0, 1.0, 1.0],
        colors: [
          Colors.black,
          Colors.black,
          Colors.transparent,
        ],
      );

  @override
  LinearGradient lerp(double t) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [t / 4, t / 2, 1.0],
      colors: const [
        Colors.black,
        Colors.black,
        Colors.transparent,
      ],
    );
  }
}
