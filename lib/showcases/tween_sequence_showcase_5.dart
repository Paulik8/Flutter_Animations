import 'package:animations/widgets/showcase_scaffold.dart';
import 'package:flutter/material.dart';

import '../duration_data.dart';

class TweenSequenceShowcase extends StatefulWidget {
  static const title = 'TweenSequenceShowcase';

  const TweenSequenceShowcase({Key? key}) : super(key: key);

  @override
  State<TweenSequenceShowcase> createState() => _TweenSequenceShowcaseState();
}

class _TweenSequenceShowcaseState extends State<TweenSequenceShowcase>
    with SingleTickerProviderStateMixin {
  final _itemCount = 6;
  final _animations = <Animation<double>>[];
  final _tweenAnimations = <Animation<Decoration>>[];
  late final TweenSequence<Decoration> _decorationTweenSequence;
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    _setupTweenSequence();
    final step = 1 / _itemCount;
    for (int i = 0; i < _itemCount; i++) {
      final curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: Interval(i * step, (i + 1) * step),
      );
      _tweenAnimations.add(_decorationTweenSequence.animate(curvedAnimation));
      _animations.add(curvedAnimation);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DurationData.of(context)?.duration;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) => ShowcaseScaffold(
        TweenSequenceShowcase.title,
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return FadeTransition(
              opacity: _animations[index],
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0.0, 1.5),
                  end: Offset.zero,
                ).animate(_animations[index]),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  final maxWidth = constraints.maxWidth;
                  return AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, _) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 100.0,
                            width: Tween(begin: 70.0, end: maxWidth)
                                .evaluate(_animations[index]),
                            decoration: _tweenAnimations[index].value,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            );
          },
          itemCount: _itemCount,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setupTweenSequence() =>
      _decorationTweenSequence = TweenSequence<Decoration>([
        TweenSequenceItem(
          tween: DecorationTween(
            begin: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            end: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
          ),
          weight: 90,
        ),
        TweenSequenceItem(
          tween: DecorationTween(
            begin: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            end: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          weight: 10,
        ),
      ]);
}
