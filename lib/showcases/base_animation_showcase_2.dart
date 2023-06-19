import 'package:animations/duration_data.dart';
import 'package:animations/widgets/showcase_scaffold.dart';
import 'package:flutter/material.dart';

class BaseAnimationShowcase extends StatefulWidget {
  static const title = 'BaseAnimationShowcase';

  const BaseAnimationShowcase({Key? key}) : super(key: key);

  @override
  State<BaseAnimationShowcase> createState() => _BaseAnimationShowcaseState();
}

class _BaseAnimationShowcaseState extends State<BaseAnimationShowcase>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this);

  late final Animation<double> _scaleAnimation;
  late final CurvedAnimation _curvedAnimation;

  Animatable<double> _scaleTween = Tween(begin: 1.0, end: 2.0);
  final CurveTween _curveTween = CurveTween(curve: Curves.bounceOut);
  Animatable<Color?> _colorTween =
      ColorTween(begin: Colors.green, end: Colors.red);

  @override
  void initState() {
    super.initState();
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
    _colorTween = _colorTween.chain(_curveTween);
    _scaleAnimation = _curvedAnimation.drive(_scaleTween);
    // _scaleTween = _scaleTween.chain(_curveTween);
    // _scaleAnimation = _scaleTween.animate(_curvedAnimation);
    // _scaleAnimation = _curvedAnimation.drive(_scaleTween);
    _controller.addListener(() {
      print('Animation value: ${_curvedAnimation.value}');
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DurationData.of(context)?.duration;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      BaseAnimationShowcase.title,
      body: Center(
        child: Transform.scale(
          // scale: _scaleTween.evaluate(_controller),
          scale: _scaleAnimation.value,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: _colorTween.evaluate(_controller),
              borderRadius: const BorderRadius.all(
                Radius.circular(70),
              ),
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
