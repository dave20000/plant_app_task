import 'dart:convert';

import 'package:dynamic_widget_app_task/models/plant.dart';
import 'package:get/state_manager.dart';

class Cart {
  int cartItemId;
  RxInt quantity;
  Plant plant;
  Cart({
    required this.cartItemId,
    required this.quantity,
    required this.plant,
  });

  Map<String, dynamic> toMap() {
    return {
      'cartItemId': cartItemId,
      'quantity': quantity,
      'plant': plant.toMap(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      quantity: map['quantity'],
      plant: Plant.fromMap(map['plant']),
      cartItemId: map['cartItemId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}
