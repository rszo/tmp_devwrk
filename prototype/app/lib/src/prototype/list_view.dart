import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './create_view.dart';
import './data/item.dart';
import './details2_view.dart';
import './details3_view.dart';
import '../settings/settings_view.dart';

/// Prototype
// ignore: use_key_in_widget_constructors
class PrototypeListView extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: _Widget(),
    );
  }
}

Future<List> fetchEntries() async {
  final response =
      await http.get(Uri.parse('http://192.168.33.10:8080/webapi/entry/list'));
  print('[${response.body}]');

  if (response.statusCode == 200) {
    var list = jsonDecode(response.body) as List;
    return list.map((model) => Item.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load entries');
  }
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> {
  late Future<List> _futureEntries;

  @override
  void initState() {
    super.initState();
    _futureEntries = fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _futureEntries,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            restorationId: 'entriesListView',
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final item = snapshot.data![index] as Item;

              return ListTile(
                  title: Text(item.title),
                  leading: Icon((item.type == 1) ? Icons.add : Icons.article),
                  onTap: () {
                    if (item.type == 1) {
                      Navigator.restorablePushNamed(
                        context,
                        PrototypeCreateView.routeName,
                      );
                    }
                    if (item.type == 2) {
                      Navigator.restorablePushNamed(
                        context,
                        PrototypeDetails2View.routeName,
                        arguments: {
                          'id': item.id,
                          'title': item.title,
                        },
                      );
                    }
                    if (item.type == 3) {
                      Navigator.restorablePushNamed(
                        context,
                        PrototypeDetails3View.routeName,
                        arguments: {
                          'id': item.id,
                          'title': item.title,
                        },
                      );
                    }
                  });
            },
          );
        } else if (snapshot.hasError) {
          print('[${snapshot.error}]');
          return ListView.builder(
            restorationId: 'entriesListView',
            itemCount: 1,
            itemBuilder: (context, index) => ListTile(
                title: const Text('追加'),
                leading: const Icon(Icons.add),
                onTap: () {
                  Navigator.restorablePushNamed(
                    context,
                    PrototypeCreateView.routeName,
                  );
                }),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
