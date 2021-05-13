import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String id;
  String name;
  String picture;
  double price;
  String description;
  String stok;
  String createdAt;
  String updatedAt;
  String category;
  String plant;

  Product({
    this.id,
    this.name,
    this.picture,
    this.price,
    this.description,
    this.stok,
    this.category,
    this.plant,
  });

  @override
  List<Object> get props => [
        id,
        name,
        picture,
        price,
        description,
        stok,
        category,
        plant,
      ];
}
