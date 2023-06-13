import 'package:flutter/material.dart';

class ShowcaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool useSafeArea;

  const ShowcaseScaffold(
    this.title, {
    required this.body,
    this.useSafeArea = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: useSafeArea ? SafeArea(child: body) : body,
      );
}
