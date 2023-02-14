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
    final dynamic appBar =
        AppBar(title: const Text('Your orders'), centerTitle: true);
    return Scaffold(
      appBar: appBar,
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSerProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('An error occurred'),
              );
            } else {
              return Consumer<OrdersProvider>(
                builder: (context, ordersProvider, child) => ListView.builder(
                  itemBuilder: (context, index) =>
                      OrderItem(orderItem: ordersProvider.orders[index]),
                  itemCount: ordersProvider.orders.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
