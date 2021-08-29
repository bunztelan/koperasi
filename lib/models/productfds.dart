import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String id;
  String name;
  String picture;
  double price;
  String description;
  int stok;
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

  // Product mockProduct = Product(
  //   id: "1",
  //   name: "mock food",
  //   picture: "https://via.placeholder.com/150",
  //   price: 300000,
  //   description: "This is mock food for test purpose only",
  //   stok: 10,
  //   category: "makanan",
  //   plant: "Sunter",
  // );

  static List<Product> mockProducts = [
    Product(
      id: "1",
      name: "mock food 1",
      picture: "https://via.placeholder.com/150",
      price: 300000,
      description: "This is mock food for test purpose only",
      stok: 10,
      category: "makanan",
      plant: "Sunter",
    ),
    Product(
      id: "2",
      name: "mock food 2",
      picture: "https://via.placeholder.com/150",
      price: 320000,
      description: "This is mock food for test purpose only",
      stok: 10,
      category: "makanan",
      plant: "Sunter",
    ),
    Product(
      id: "3",
      name: "mock food 3",
      picture: "https://via.placeholder.com/150",
      price: 330000,
      description: "This is mock food for test purpose only",
      stok: 10,
      category: "makanan",
      plant: "Sunter",
    ),
  ];
}
