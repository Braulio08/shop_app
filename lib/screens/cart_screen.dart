import 'package:flutter/material.dart';
import '../widgets/cart_item_widget.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Chip(label: Text('\$${cartProvider.totalAmount}')),
                  TextButton(onPressed: () {}, child: const Text('ORDER NOW'))
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartItem(cartItem: cartProvider.items.values.toList()[index], productId: cartProvider.items.keys.toList()[index]),
              itemCount: cartProvider.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
