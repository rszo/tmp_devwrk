import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './data/item.dart';
import './data/item3.dart';

/// Displays detailed information about a SampleItem.
class PrototypeDetails3View extends StatelessWidget {
  const PrototypeDetails3View({Key? key}) : super(key: key);

  static const routeName = '/sample_item3';

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

Future<Item3> fetchEntry(int id) async {
  final response = await http
      .get(Uri.parse('http://192.168.33.10:8080/webapi/entry/get3/$id'));
  print('[${response.body}]');

  if (response.statusCode == 200) {
    return Item3.fromJson(jsonDecode(response.body));
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

  late Future<Item3> _futureEntry;

  @override
  void initState() {
    super.initState();
    _futureEntry = fetchEntry(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Item3>(
      future: _futureEntry,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: Theme.of(context).dividerColor,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: const EdgeInsets.all(16),
            child: Image.memory(base64Decode(snapshot.data!.image)),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
