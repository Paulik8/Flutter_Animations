import 'package:flutter/material.dart';
import 'duration_data.dart';
import 'main.dart';
import 'showcases/cards_showcase_1.dart';
import 'showcases/waves_showcase_2.dart';
import 'showcases/cards_gradient_showcase_3.dart';
import 'showcases/simple_transitions_showcase_4.dart';
import 'showcases/tween_sequence_showcase_5.dart';

class MainPage extends StatelessWidget {
  static const _map = <String, Widget>{
    CardsShowcase.title: CardsShowcase(),
    WavesShowcase.title: WavesShowcase(),
    SimpleTransitionsShowcase.title: SimpleTransitionsShowcase(),
    CardsGradientShowcase.title: CardsGradientShowcase(),
    TweenSequenceShowcase.title: TweenSequenceShowcase(),
  };

  final void Function(double) onSliderChanged;

  const MainPage({
    required this.onSliderChanged,
    super.key,
  });

  void pushShowcase(String title) {
    navigatorKey.currentState?.pushNamed(title);
  }

  @override
  Widget build(BuildContext context) {
    final durationValue = DurationData.of(context)!.durationValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ..._map.entries
                .map(
                  (entry) => _MainItem(
                    title: entry.key,
                    onTap: () => pushShowcase(entry.key),
                  ),
                )
                .toList(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: kBottomNavigationBarHeight,
          child: Slider(
            max: 4000,
            activeColor: Colors.green,
            inactiveColor: Colors.purple,
            thumbColor: Colors.black,
            label: durationValue.round().toString(),
            divisions: 40,
            value: durationValue,
            onChanged: onSliderChanged,
          ),
        ),
      ),
    );
  }
}

class _MainItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MainItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white12,
            border: Border(bottom: BorderSide()),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(title),
        ),
      );
}
