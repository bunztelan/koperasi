import 'dart:convert';

class Product {
  int id;
  int categoryId;
  String name;
  String description;
  int stock;
  int price;
  bool status;
  int maritalQuota;
  int regulerQuota;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<String> images;
  bool isBuyable;

  Product({
    this.id = 0,
    this.categoryId = 0,
    this.name = '',
    this.description = '',
    this.stock = 0,
    this.price = 0,
    this.status = false,
    this.maritalQuota = 0,
    this.regulerQuota = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.deletedAt = '',
    this.images = const [],
    this.isBuyable = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'stock': stock,
      'price': price,
      'status': status,
      'maritalQuota': maritalQuota,
      'regulerQuota': regulerQuota,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'images': images,
      'isBuyable': isBuyable,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      categoryId: map['category_id'],
      name: map['name'],
      description: map['description'],
      stock: map['stock'],
      price: map['price'],
      status: map['status'],
      maritalQuota: map['marital_quota'],
      regulerQuota: map['reguler_quota'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
      images: null,
      isBuyable: map['is_buyable'],
    );
  }

  factory Product.fromLocalMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      categoryId: map['categoryId'],
      name: map['name'],
      description: map['description'],
      stock: map['stock'],
      price: map['price'],
      status: map['status'],
      maritalQuota: map['maritalQuota'],
      regulerQuota: map['regulerQuota'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      images: null,
      isBuyable: map['isBuyable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
