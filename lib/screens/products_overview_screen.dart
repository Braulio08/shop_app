import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';
import '../enums/filter_options.dart';
import '../widgets/products_grid.dart';
import 'package:badges/badges.dart' as badges;

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});
  static const routeName = '/products-overview-screen';

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    //Provider.of<ProductsProvider>(context).fetchAndSerProducts();
    // Future.delayed(Duration.zero).then((value) =>
    //     Provider.of<ProductsProvider>(context).fetchAndSerProducts());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context)
          .fetchAndSerProducts()
          .then((value) => _isLoading = false);
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

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
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(showFavs: _showOnlyFavorites),
    );
  }
}
