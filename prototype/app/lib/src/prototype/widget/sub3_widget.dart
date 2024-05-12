import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import './image_widget.dart';

/// Prototype
class Sub3View extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Divider(),
          _Widget(),
        ],
      );
}

Future<String> makeEntry(String title, Uint8List image) async {
  if (title.isEmpty) {
    return 'NG [Empty String]';
  }
  try {
    final response = await http.post(
      Uri.parse('http://192.168.33.10:8080/webapi/entry/add3'),
      body: makeBody(title, image),
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

Map makeBody(String title, Uint8List image) {
  return {
    'title': title,
    'image': base64Encode(image),
  };
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> {
  final _controller = TextEditingController();

  final _picker = ImagePicker();

  XFile? _image;

  Uint8List? _imageBytes;

  dynamic _pickImageError;

  Future<String>? _futureEntry;

  Future<void> _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      final Uint8List? bytes = await pickedFile!.readAsBytes();
      setState(() {
        _image = pickedFile;
        _imageBytes = bytes;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'タイトル',
          ),
          maxLines: 1,
        ),
        ImageWidget(
          children: [
            TextButton.icon(
              onPressed: () => _onImageButtonPressed(ImageSource.gallery),
              icon: const Icon(Icons.source),
              label: Text((_image != null) ? _image!.name : '画像なし'),
            ),
            if (_imageBytes != null)
              Image.memory(_imageBytes!)
            else if (_pickImageError != null)
              Text('Pick image error: $_pickImageError'),
          ],
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
        else if (_imageBytes != null)
          ElevatedButton(
            onPressed: () {
              setState(() {
                _futureEntry = makeEntry(_controller.text, _imageBytes!);
              });
            },
            child: const Text('送信'),
          ),
      ],
    );
  }
}
