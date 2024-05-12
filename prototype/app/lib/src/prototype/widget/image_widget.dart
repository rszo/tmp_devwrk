import 'package:flutter/material.dart';

/// Prototype
class ImageWidget extends StatelessWidget {
  final List<Widget> children;

  // ignore: use_key_in_widget_constructors
  const ImageWidget({
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      );
}
