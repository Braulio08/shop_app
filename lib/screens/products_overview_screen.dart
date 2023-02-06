import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';
import '../enums/filter_options.dart';
import '../widgets/products_grid.dart';
import 'package:badges/badges.dart' as badges;

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop app'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show all'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.only(right: 15),
              child: Consumer<CartProvider>(
                builder: (context, value, child) => badges.Badge(
                  badgeAnimation: const badges.BadgeAnimation.scale(),
                  showBadge: value.itemCount > 0 ? true : false,
                  badgeContent: Text(value.itemCount.toString()),
                  child: child,
                ),
                child: const Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
            onTap: () => Navigator.of(context).pushNamed(CartScreen.routeName),
          ),
        ],
      ),
      body: ProductsGrid(showFavs: _showOnlyFavorites),
    );
  }
}
