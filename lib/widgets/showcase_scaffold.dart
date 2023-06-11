import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowcaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const ShowcaseScaffold(
    this.title, {
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: body,
      );
}
