import 'package:flutter/material.dart';

import '../models/page_param.dart';

class HousePage extends Page {
  final HousePageParam obj;

  static const routeName = '/house';

  HousePage({
    required this.obj,
  }) : super(key: ValueKey(obj));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => HouseWidget(obj: obj),
    );
  }
}

class HouseWidget extends StatelessWidget {
  final HousePageParam obj;

  const HouseWidget({
    Key? key,
    required this.obj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
