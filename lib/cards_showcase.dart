import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/showcase_scaffold.dart';

class CardsShowcase extends StatelessWidget {
  static const title = 'CardsShowcase';

  const CardsShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ShowcaseScaffold(
        CardsShowcase.title,
        body: ListView(
          children: List.generate(
            6,
            (index) => const AnimatedCard(),
          ),
        ),
      );
}

class AnimatedCard extends StatefulWidget {
  const AnimatedCard({Key? key}) : super(key: key);

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  static const _duration = Duration(milliseconds: 2000);
  static const _collapsedHeight = 70.0;
  static const _expandedHeight = 120.0;
  static const _color = Colors.orange;
  static const _expandedText =
      'ewkgokweg[ewkgpwelgpkwgkewokgwegkwekgowegwegwegewlweflewpflwepflpwelfwelfpewlfwelfwelfewplfwlflwpwelfpwlpflpwefplwpelfpwe';

  bool _isExpanded = false;
  late ColorTween _colorTween;

  void _toggleCard() => setState(() => _isExpanded = !_isExpanded);

  @override
  void initState() {
    super.initState();
    _colorTween = ColorTween(
      begin: _color,
      end: _color.withOpacity(0.4),
    ); // TODO(): написать градиентный твин
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedContainer(
        duration: _duration,
        height: _isExpanded ? _expandedHeight : _collapsedHeight,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: _isExpanded ? _color : _color.withOpacity(0.4),
        ),
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('title'),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: _duration,
                    child: SvgPicture.asset(
                      'assets/svg/arrow.svg',
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AnimatedCrossFade(
                // TODO(): посмотреть как устроен AnimatedSwitcher
                firstChild: const SizedBox(width: double.infinity),
                secondChild: const Text(_expandedText),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: _duration,
              ),
            ],
          ),
        ),
        // child: ColoredBox(
        //   color: _isExpanded ? _color : _color.withOpacity(0.4),
        //   child: SizedBox(
        //     height: _isExpanded ? _expandedHeight : _collapsedHeight,
        //     width: double.infinity,
        //   ),
        // ),
      ),
    );
  }
}

class GradientTween extends Tween<LinearGradient?> {
  @override
  LinearGradient? lerp(double t) => LinearGradient.lerp(
        const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.black, Colors.transparent],
        ),
        const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.black],
        ),
        t,
      );
}
