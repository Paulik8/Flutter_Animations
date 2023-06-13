import 'package:flutter/material.dart';

class DurationData extends InheritedWidget {
  final Duration duration;
  final double durationValue;

  const DurationData({
    required this.duration,
    required this.durationValue,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(DurationData oldWidget) =>
      duration != oldWidget.duration ||
      durationValue != oldWidget.durationValue;

  static DurationData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DurationData>();
}
