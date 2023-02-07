import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class ProductsOrder extends StatelessWidget {
  const ProductsOrder({super.key, required this.product});

  final CartItem product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          '${product.quantity}x \$${product.price}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
