import 'package:flutter/material.dart';

import './widget/sub2_widget.dart';
import './widget/sub3_widget.dart';

/// Prototype
class PrototypeCreateView extends StatelessWidget {
  static const routeName = '/create';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('データ追加'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: _Widget(),
        ),
      );
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> {
  int dropdownValue = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButton<int>(
          value: dropdownValue,
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: const [
            DropdownMenuItem(value: 2, child: Text('コマンド登録')),
            DropdownMenuItem(value: 3, child: Text('画像登録')),
          ],
        ),
        if (dropdownValue == 2) Sub2View(),
        if (dropdownValue == 3) Sub3View(),
      ],
    );
  }
}
