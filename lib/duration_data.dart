import 'package:flutter/material.dart';

class DurationData extends InheritedWidget {
  final Duration duration;

  const DurationData({
    required this.duration,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(DurationData oldWidget) =>
      duration != oldWidget.duration;

  static DurationData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DurationData>();
}
