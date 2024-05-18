class House {
  final int id;

  House(this.id);
}

class HouseEntry {
  final int id;

  HouseEntry(this.id);
  HouseEntry.fromJson(Map<String, dynamic> json) : id = json['id'];
}
