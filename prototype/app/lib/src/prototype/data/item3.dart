import './item.dart';

/// A placeholder class that represents an entity or model.
class Item3 extends Item {
  const Item3(int id, String title, this.image) : super(id, 3, title);

  final String image;

  factory Item3.fromJson(Map<String, dynamic> json) {
    return Item3(
      json['id'],
      json['entry']['title'],
      json['image'],
    );
  }
}
