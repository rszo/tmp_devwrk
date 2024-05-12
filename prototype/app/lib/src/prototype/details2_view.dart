import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './data/item.dart';
import './data/item2.dart';

/// Displays detailed information about a SampleItem.
class PrototypeDetails2View extends StatelessWidget {
  const PrototypeDetails2View({Key? key}) : super(key: key);

  static const routeName = '/sample_item2';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(args['title']),
      ),
      body: _Widget(args['id']),
    );
  }
}

Future<Item2> fetchEntry(int id) async {
  final response = await http
      .get(Uri.parse('http://192.168.33.10:8080/webapi/entry/get2/$id'));
  print('[${response.body}]');

  if (response.statusCode == 200) {
    return Item2.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load entries');
  }
}

class _Widget extends StatefulWidget {
  const _Widget(this.id);

  final int id;

  @override
  State<StatefulWidget> createState() => _State(id);
}

class _State extends State<_Widget> {
  _State(this.id);

  final int id;

  late Future<Item2> _futureEntry;

  @override
  void initState() {
    super.initState();
    _futureEntry = fetchEntry(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Item2>(
      future: _futureEntry,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller:
                    TextEditingController(text: snapshot.data!.filename),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'コマンド',
                ),
                readOnly: true,
              ),
              TextField(
                controller:
                    TextEditingController(text: snapshot.data!.arguments),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'パラメーター',
                ),
                readOnly: true,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
