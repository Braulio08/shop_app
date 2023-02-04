import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
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
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return ChangeNotifierProvider(
        create: (context) => ProductsProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: lightColorScheme ?? MyApp._defaultLightColorScheme,
            useMaterial3: true,
            fontFamily: 'Lato'
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? MyApp._defaultDarkColorScheme,
            useMaterial3: true,
            fontFamily: 'Lato'
          ),
          themeMode: ThemeMode.system,
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName:(context) => const ProductDetailScreen(),
          },
        ),
      );
    });
  }
}
