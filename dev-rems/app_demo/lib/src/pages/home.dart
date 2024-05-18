import 'package:flutter/material.dart';

import '../models/search_option.dart';

typedef _NavWidget = ElevatedButton;

class HomePage extends StatelessWidget {
  static const routeName = '/';

  final ValueChanged<SearchOption> onPressed;

  // ignore: use_key_in_widget_constructors
  const HomePage({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(children: const [
              Image(
                image: NetworkImage(
                    'https://www.nissei-f.co.jp/images/share/logo.gif'),
              ),
              Image(
                image: NetworkImage(
                    'https://www.nissei-f.co.jp/images/share/logo2.gif'),
              ),
            ]),
            const Image(
              image: NetworkImage(
                  'https://www.nissei-f.co.jp/images/index/main_pic1.jpg'),
            ),
            Wrap(
              children: [
                _NavWidget(
                    onPressed: () => onPressed(SearchOption(1)),
                    child: const Text('リース店舗を探す')),
                _NavWidget(
                    onPressed: () => onPressed(SearchOption(2)),
                    child: const Text('店舗物件を探す')),
                _NavWidget(
                    onPressed: () => onPressed(SearchOption(3)),
                    child: const Text('事務所物件を探す')),
                _NavWidget(
                    onPressed: () => onPressed(SearchOption(4)),
                    child: const Text('賃貸物件を探す')),
                _NavWidget(
                    onPressed: () => onPressed(SearchOption(5)),
                    child: const Text('売買物件を探す')),
                _NavWidget(
                    onPressed: () => onPressed(SearchOption(6)),
                    child: const Text('駐車場を探す')),
              ],
            ),
            const Text('サンプル不動産'),
          ],
        ),
      ),
    );
  }
}
