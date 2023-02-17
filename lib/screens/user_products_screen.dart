import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});
  static const routeName = '/user-products-screen';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    final dynamic appBar = AppBar(
      title: const Text('Your products'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(EditProductScreen.routeName),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: appBar,
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<ProductsProvider>(
                      builder: (context, productsProvider, child) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: (context, index) => Column(
                            children: [
                              UserProductItem(
                                  product: productsProvider.items[index]),
                              const Divider(),
                            ],
                          ),
                          itemCount: productsProvider.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
