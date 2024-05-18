import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/house.dart';
import '../models/page_param.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  final SearchPageParam param;
  final ValueChanged<HouseEntry> onTapped;

  // List<HouseEntry>? _entries;

  // ignore: use_key_in_widget_constructors
  const SearchPage({
    required this.param,
    required this.onTapped,
  });

  // ignore: use_key_in_widget_constructors
  SearchPage.fromAsset({
    required this.onTapped,
  }) : param = SearchPageParam(0);

  // ignore: unused_element
  static _sample() => [
        HouseEntry(0),
        HouseEntry(1),
        HouseEntry(2),
      ];

  Future<List<HouseEntry>> _asset() async {
    final asset = await rootBundle.loadString('assets/json/entities.json');
    return (jsonDecode(asset) as List)
        .map((e) => HouseEntry.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) => _SearchWidget(
              maxWidth: constraints.maxWidth,
            ),
          ),
          FutureBuilder(
            future: _asset(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("ロード中");
              }
              final data = snapshot.data as List<HouseEntry>;
              return Flexible(
                child: ListView(
                  children: [
                    for (var entry in data)
                      ListTile(
                        title: Text(entry.id.toString()),
                        subtitle: Text(entry.id.toString()),
                        onTap: () => onTapped(entry),
                      )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  // final double itemWidth;
  final double maxWidth;

  const _SearchWidget({
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final itemWidth = !(1024 > maxWidth) ? 504.0 : double.infinity;
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        SizedBox(
          width: itemWidth,
          child: const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '地域',
            ),
          ),
        ),
        SizedBox(
          width: itemWidth,
          child: const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'タイプ',
            ),
          ),
        ),
      ],
    );
  }
}
