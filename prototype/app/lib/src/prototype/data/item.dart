import '../../sample_feature/sample_item.dart';

/// A placeholder class that represents an entity or model.
class Item extends SampleItem {
  const Item(
    int id,
    this.type,
    this.title,
  ) : super(id);

  final int type;

  final String title;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      (json['type'] != '1') ? json['id'] : 0,
      int.parse(json['type']),
      json['title'],
    );
  }
}
