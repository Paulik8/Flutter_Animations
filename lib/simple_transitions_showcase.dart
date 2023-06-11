import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleTransitionsShowcase extends StatefulWidget {
  const SimpleTransitionsShowcase({Key? key}) : super(key: key);

  @override
  State<SimpleTransitionsShowcase> createState() =>
      _SimpleTransitionsShowcaseState();
}

class _SimpleTransitionsShowcaseState extends State<SimpleTransitionsShowcase>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<AlignmentGeometry> _alignmentGeometryAnimation;
  late final Animation<double> _scaleTransition;
  late final Animation<Decoration> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
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
    ).animate(curvedAnimation);
    _animationController.repeat();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: AlignTransition(
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
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomTransition(
          alignmentGeometryAnimation: _alignmentGeometryAnimation,
          scaleTransition: _scaleTransition,
          borderRadiusAnimation: _borderRadiusAnimation,
        ),
      ),
    );
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
  Widget build(BuildContext context) {
    return AlignTransition(
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
}
