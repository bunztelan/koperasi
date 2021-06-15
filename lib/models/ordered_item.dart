import 'dart:convert';

import 'package:k2ms_v2/models/order.dart';

class OrderedItem {
  int id;
  int userId;
  int plantId;
  int customerAddressId;
  String method;
  String status;
  String reason;
  String note;
  int totalPrice;
  String addressStreet;
  String addressDescription;
  double addressLatitude;
  double addressLongitude;
  List<Order> orders;
  String updatedAt;

  OrderedItem({
    this.id = 0,
    this.userId = 0,
    this.plantId = 0,
    this.customerAddressId = 0,
    this.method = '',
    this.status = '',
    this.reason = '',
    this.note = '',
    this.totalPrice = 0,
    this.addressStreet = '',
    this.addressDescription = '',
    this.addressLatitude = 0,
    this.addressLongitude = 0,
    this.orders = const [],
    this.updatedAt = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'plantId': plantId,
      'customerAddressId': customerAddressId,
      'method': method,
      'status': status,
      'reason': reason,
      'note': note,
      'totalPrice': totalPrice,
      'addressStreet': addressStreet,
      'addressDescription': addressDescription,
      'addressLatitude': addressLatitude,
      'addressLongitude': addressLongitude,
    };
  }

  factory OrderedItem.fromMap(Map<String, dynamic> map) {
    return OrderedItem(
      id: map['id'],
      userId: map['user_id'],
      plantId: map['plant_id'],
      customerAddressId: map['customer_address_id'],
      method: map['method'],
      status: map['status'],
      reason: map['reason'],
      note: map['note'],
      totalPrice: map['total_price'],
      addressStreet: map['address_street'],
      addressDescription: map['address_description'],
      addressLatitude: map['address_latitude'],
      addressLongitude: map['address_longitude'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderedItem.fromJson(String source) =>
      OrderedItem.fromMap(json.decode(source));
}
