import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_order.dart';
import '../models/order_item.dart' as item;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  const OrderItem({super.key, required this.orderItem});
  final item.OrderItem orderItem;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}',
                style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                .format(widget.orderItem.dateTime)),
            trailing: IconButton(
              onPressed: () => setState(() {
                _expanded = !_expanded;
              }),
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.orderItem.products.length * 30.0 + 10, 150),
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    ProductsOrder(product: widget.orderItem.products[index]),
                itemCount: widget.orderItem.products.length,
              ),
            ),
        ],
      ),
    );
  }
}
