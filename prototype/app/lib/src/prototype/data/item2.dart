import './item.dart';

/// A placeholder class that represents an entity or model.
class Item2 extends Item {
  const Item2(int id, String title, this.filename, this.arguments)
      : super(id, 2, title);

  final String filename;

  final String arguments;

  factory Item2.fromJson(Map<String, dynamic> json) {
    return Item2(
      json['id'],
      json['entry']['title'],
      json['cmd'],
      json['args'],
    );
  }
}
