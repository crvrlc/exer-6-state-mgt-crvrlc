import 'package:flutter/material.dart';
import 'package:my_app/screen/checkout.dart';
import 'package:my_app/screen/my_cart.dart';
import 'package:my_app/screen/my_catalog.dart';
import 'package:provider/provider.dart';
import 'provider/shoppingcart_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ShoppingCart()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: "/",
      routes: {
        "/cart": (context) => const MyCart(),
        "/products": (context) => const MyCatalog(),
        "/checkout": (context) =>
            const Checkout(), // added the route for checkout
      },
      home: const MyCatalog(),
    );
  }
}
