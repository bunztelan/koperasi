import 'dart:convert';

class Plant {
  int id;
  String name;
  String imagePath;
  String description;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Plant({
    this.id,
    this.name,
    this.imagePath,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_path': imagePath,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      name: map['name'],
      imagePath: map['image_path'],
      description: map['description'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plant.fromJson(String source) => Plant.fromMap(json.decode(source));
}
