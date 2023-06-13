import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../duration_data.dart';
import '../widgets/showcase_scaffold.dart';

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
  static const _collapsedHeight = 70.0;
  static const _expandedHeight = 120.0;
  static const _color = Colors.orange;

  bool _isExpanded = false;
  late Duration _duration;

  void _toggleCard() => setState(() => _isExpanded = !_isExpanded);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _duration = DurationData.of(context)!.duration;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
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
                    const Text('Card Title'),
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
                  firstChild: const SizedBox(width: double.infinity),
                  secondChild: const Text(
                    placeholderText,
                    maxLines: null,
                    overflow: TextOverflow.clip,
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: _duration,
                ),
              ],
            ),
          ),
        ),
      );
}

const placeholderText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc non blandit massa enim nec dui nunc mattis enim.';
