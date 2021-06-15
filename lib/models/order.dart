import 'dart:convert';

import 'package:k2ms_v2/models/product.dart';

class Order {
  Product product;
  int qty;

  Order({
    this.product,
    this.qty = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'qty': qty,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      product: Product.fromLocalMap(map['product']),
      qty: map['qty'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
