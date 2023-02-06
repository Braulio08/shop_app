import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart_provider.dart';
import '../models/cart_item.dart' as item;
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItem, required this.productId});
  final item.CartItem cartItem;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) =>
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(productId),
      direction: DismissDirection.endToStart,
      key: ValueKey(cartItem.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 30,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('\$${cartItem.price}')),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text('\$${(cartItem.price * cartItem.quantity)}'),
            trailing: Text('${cartItem.quantity} x'),
          ),
        ),
      ),
    );
  }
}
