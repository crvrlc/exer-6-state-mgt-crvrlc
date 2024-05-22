// contains code for catalog

import 'package:flutter/material.dart';
import '../model/item.dart';
import "package:provider/provider.dart";
import '../provider/shoppingcart_provider.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  List<Item> productsCatalog = [
    Item("Shampoo", 10.00, 2),
    Item("Soap", 12.00, 3),
    Item("Toothpaste", 40.00, 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            title: const Text(
              "Product Catalog",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
        body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.star),
                title: Text(
                  "${productsCatalog[index].name}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("₱${productsCatalog[index].price}"),
                trailing: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepOrangeAccent),
                  ),
                  child: const Text("Add to Cart"),
                  onPressed: () {
                    context
                        .read<ShoppingCart>()
                        .addItem(productsCatalog[index]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${productsCatalog[index].name} added!"),
                      duration: const Duration(seconds: 1, milliseconds: 100),
                    ));
                  },
                ),
              );
            },
            itemCount: productsCatalog.length),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/cart");
          },
        ));
  }
}
