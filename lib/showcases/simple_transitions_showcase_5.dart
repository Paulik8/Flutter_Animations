import 'package:animations/widgets/showcase_scaffold.dart';
import 'package:flutter/material.dart';

import '../duration_data.dart';

class SimpleTransitionsShowcase extends StatefulWidget {
  static const title = 'SimpleTransitionsShowcase';

  const SimpleTransitionsShowcase({Key? key}) : super(key: key);

  @override
  State<SimpleTransitionsShowcase> createState() =>
      _SimpleTransitionsShowcaseState();
}

class _SimpleTransitionsShowcaseState extends State<SimpleTransitionsShowcase>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(vsync: this);
  late final Animation<AlignmentGeometry> _alignmentGeometryAnimation;
  late final Animation<double> _scaleTransition;
  late final Animation<Decoration> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );
    _alignmentGeometryAnimation = curvedAnimation.drive(
      Tween(
        begin: Alignment.center,
        end: Alignment.bottomCenter,
      ),
    );
    _scaleTransition = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(curvedAnimation);
    _borderRadiusAnimation = DecorationTween(
      begin: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(70.0)),
      ),
      end: const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ).chain(CurveTween(curve: Curves.bounceOut)).animate(_animationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.duration = DurationData.of(context)?.duration;
    _animationController.repeat();
  }

  // @override
  // Widget build(BuildContext context) => ShowcaseScaffold(
  //       SimpleTransitionsShowcase.title,
  //       body: AlignTransition(
  //         alignment: _alignmentGeometryAnimation,
  //         child: ScaleTransition(
  //           scale: _scaleTransition,
  //           child: DecoratedBoxTransition(
  //             decoration: _borderRadiusAnimation,
  //             child: Container(
  //               alignment: Alignment.center,
  //               width: 100,
  //               height: 100,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

@override
Widget build(BuildContext context) => ShowcaseScaffold(
      SimpleTransitionsShowcase.title,
      body: CustomTransition(
        alignmentGeometryAnimation: _alignmentGeometryAnimation,
        scaleTransition: _scaleTransition,
        borderRadiusAnimation: _borderRadiusAnimation,
      ),
    );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CustomTransition extends AnimatedWidget {
  final Animation<AlignmentGeometry> alignmentGeometryAnimation;
  final Animation<double> scaleTransition;
  final Animation<Decoration> borderRadiusAnimation;

  CustomTransition({
    required this.alignmentGeometryAnimation,
    required this.scaleTransition,
    required this.borderRadiusAnimation,
    super.key,
  }) : super(
          listenable: Listenable.merge(
            [
              alignmentGeometryAnimation,
              scaleTransition,
              borderRadiusAnimation,
            ],
          ),
        );

  @override
  Widget build(BuildContext context) => AlignTransition(
        alignment: alignmentGeometryAnimation,
        child: ScaleTransition(
          scale: scaleTransition,
          child: DecoratedBoxTransition(
            decoration: borderRadiusAnimation,
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
}
