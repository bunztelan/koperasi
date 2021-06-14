import 'package:k2ms_v2/models/product.dart';

class Order {
  Product product;
  int qty;

  Order({
    this.product,
    this.qty = 0,
  });
}
