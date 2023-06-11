import 'package:animations/duration_data.dart';
import 'package:flutter/material.dart';

import 'cards_showcase.dart';
import 'cards_showcase_new.dart';
import 'simple_transitions_showcase.dart';
import 'tween_sequence_showcase.dart';
import 'waves_showcase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: _ShowcaseApp(),
    );
  }
}

class _ShowcaseApp extends StatefulWidget {
  const _ShowcaseApp({Key? key}) : super(key: key);

  @override
  State<_ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<_ShowcaseApp> {
  late final _map = <String, Widget>{
    'CardsShowcase': const CardsShowcase(),
    'SimpleTransitionsShowcase': const SimpleTransitionsShowcase(),
    'WavesShowcase': const WavesShowcase(),
    'CardsShowcaseNew': const CardsShowcaseNew(),
    'TweenSequenceShowcase': const TweenSequenceShowcase(),
  };

  @override
  Widget build(BuildContext context) {
    return DurationData(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Showcases'),
        ),
        body: ListView(
          children: _map.entries
              .map(
                (entry) => _MainItem(
                  title: entry.key,
                  child: entry.value,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _MainItem extends StatelessWidget {
  final String title;
  final Widget child;

  const _MainItem({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => push(child, context),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(16),
        color: Colors.white12,
        child: Text(title),
      ),
    );
  }

  void push(Widget page, BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
}
