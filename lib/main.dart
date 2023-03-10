import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import './screens/splash_screen.dart';
import './providers/auth_provider.dart';
import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './providers/orders_provider.dart';
import './screens/cart_screen.dart';
import './providers/cart_provider.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './helpers/custom_route.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => AuthProvider(),
            ),
            ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
              create: (context) => ProductsProvider('', '', []),
              update: (context, authProvider, previous) => ProductsProvider(
                  authProvider.token.toString(),
                  authProvider.userId.toString(),
                  previous == null ? [] : previous.items),
            ),
            ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
              create: (context) => OrdersProvider('', '', []),
              update: (context, authProvider, previous) => OrdersProvider(
                  authProvider.token.toString(),
                  authProvider.userId.toString(),
                  previous == null ? [] : previous.orders),
            ),
            ChangeNotifierProvider(
              create: (context) => CartProvider(),
            ),
          ],
          child: Consumer<AuthProvider>(
            builder: (context, auth, child) => MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: lightColorScheme ?? MyApp._defaultLightColorScheme,
                useMaterial3: true,
                fontFamily: 'Lato',
                pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: CustomPageTransitionBuilder(),
                    TargetPlatform.iOS: CustomPageTransitionBuilder(),
                  },
                ),
              ),
              darkTheme: ThemeData(
                  colorScheme: darkColorScheme ?? MyApp._defaultDarkColorScheme,
                  useMaterial3: true,
                  fontFamily: 'Lato'),
              themeMode: ThemeMode.system,
              home: auth.isAuth
                  ? const ProductsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (context, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? const SplashScreen()
                              : const AuthScreen(),
                    ),
              routes: {
                ProductDetailScreen.routeName: (context) =>
                    const ProductDetailScreen(),
                CartScreen.routeName: (context) => const CartScreen(),
                OrdersScreen.routeName: (context) => const OrdersScreen(),
                UserProductsScreen.routeName: (context) =>
                    const UserProductsScreen(),
                EditProductScreen.routeName: (context) =>
                    const EditProductScreen(),
                ProductsOverviewScreen.routeName: (context) =>
                    const ProductsOverviewScreen(),
              },
            ),
          ),
        );
      },
    );
  }
}
