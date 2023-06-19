import 'package:animations/duration_data.dart';
import 'package:animations/main_page.dart';
import 'package:flutter/material.dart';

import 'showcases/cards_showcase_1.dart';
import 'showcases/base_animation_showcase_2.dart';
import 'showcases/simple_transitions_showcase_3.dart';
import 'showcases/waves_showcase_4.dart';
import 'showcases/cards_gradient_showcase_5.dart';
import 'showcases/tween_sequence_showcase_6.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'Flutter Animations',
        home: _ShowcaseApp(),
      );
}

class _ShowcaseApp extends StatefulWidget {
  const _ShowcaseApp({Key? key}) : super(key: key);

  @override
  State<_ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<_ShowcaseApp> {
  double _durationValue = 2000;
  late Duration _duration = Duration(milliseconds: _durationValue.round());

  Route generatePage(child) {
    return MaterialPageRoute(builder: (context) => child);
  }

  void _changeDuration(double value) {
    setState(() {
      _durationValue = value;
      _duration = Duration(milliseconds: _durationValue.round());
    });
  }

  @override
  Widget build(BuildContext context) => DurationData(
        durationValue: _durationValue,
        duration: _duration,
        child: Navigator(
            key: navigatorKey,
            initialRoute: 'main',
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case 'main':
                  return generatePage(
                    MainPage(onSliderChanged: _changeDuration),
                  );
                case 'CardsShowcase':
                  return generatePage(
                    const CardsShowcase(),
                  );
                case 'CardsGradientShowcase':
                  return generatePage(
                    const CardsGradientShowcase(),
                  );
                case 'WavesShowcase':
                  return generatePage(
                    const WavesShowcase(),
                  );
                case 'BaseAnimationShowcase':
                  return generatePage(
                    const BaseAnimationShowcase(),
                  );
                case 'SimpleTransitionsShowcase':
                  return generatePage(
                    const SimpleTransitionsShowcase(),
                  );
                case 'TweenSequenceShowcase':
                  return generatePage(
                    const TweenSequenceShowcase(),
                  );
              }
              return null;
            }),
      );
}
