import 'dart:convert';

class Category {
  int id;
  String name;
  String imageId;
  bool status;
  bool isBuyable;

  Category({
    this.id = 0,
    this.name = '',
    this.imageId = '',
    this.status = false,
    this.isBuyable = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageId': imageId,
      'status': status,
      'isBuyable': isBuyable,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      imageId: map['imageId'],
      status: map['status'],
      isBuyable: map['isBuyable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
