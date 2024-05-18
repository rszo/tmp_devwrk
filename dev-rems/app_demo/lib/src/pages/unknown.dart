import 'package:flutter/material.dart';

import '../models/page_enum.dart';

class UnknownPage extends StatelessWidget {
  static const routeName = '/404';

  final ValueChanged<Segment> onPressed;

  // ignore: use_key_in_widget_constructors
  const UnknownPage({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('404 error'),
          TextButton(
            onPressed: () => onPressed(Segment.home),
            child: const Text('Go Home'),
          ),
        ],
      ),
    );
  }
}
