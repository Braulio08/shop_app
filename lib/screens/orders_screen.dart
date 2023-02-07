import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final dynamic appBar =
        AppBar(title: const Text('Your orders'), centerTitle: true);
    return Scaffold(
      appBar: appBar,
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            OrderItem(orderItem: ordersProvider.orders[index]),
        itemCount: ordersProvider.orders.length,
      ),
    );
  }
}
