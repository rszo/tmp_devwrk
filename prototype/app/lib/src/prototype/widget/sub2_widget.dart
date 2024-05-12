import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Prototype
class Sub2View extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _Widget();
}

Future<String> makeEntry(
  String title,
  String cmd,
  String args,
) async {
  if (title.isEmpty || cmd.isEmpty || args.isEmpty) {
    return 'NG [Empty String]';
  }
  try {
    final response = await http.post(
      Uri.parse('http://192.168.33.10:8080/webapi/entry/add2'),
      body: {
        'title': title,
        'cmd': cmd,
        'args': args,
      },
    );
    if (response.statusCode == 200) {
      return 'OK [${response.body}]';
    } else {
      print('${response.statusCode} : ${response.body}');
    }
  } catch (e) {
    return 'NG [$e]';
  }
  throw Exception('Failed to create entry.');
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> {
  final _controller1 = TextEditingController();

  final _controller2 = TextEditingController();

  final _controller3 = TextEditingController();

  Future<String>? _futureEntry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'タイトル',
          ),
          maxLines: 1,
        ),
        TextField(
          controller: _controller2,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'コマンド',
          ),
          maxLines: 1,
        ),
        TextField(
          controller: _controller3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'パラメーター',
          ),
          maxLines: 1,
        ),
        if (_futureEntry != null)
          FutureBuilder<String>(
            future: _futureEntry,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          )
        else
          ElevatedButton(
            onPressed: () {
              setState(() {
                _futureEntry = makeEntry(
                  _controller1.text,
                  _controller2.text,
                  _controller3.text,
                );
              });
            },
            child: const Text('送信'),
          ),
      ],
    );
  }
}
