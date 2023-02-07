import 'package:flutter/material.dart';
import 'package:shop_app/models/order_item.dart';

import '../models/cart_item.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
