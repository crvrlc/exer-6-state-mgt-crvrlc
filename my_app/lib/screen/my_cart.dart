// contains code for cart

import 'package:flutter/material.dart';
import '../model/item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text(
            "My Cart",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
          SizedBox(height: 20),
          computeCost(),
          SizedBox(height: 20),
          const Divider(height: 4, color: Colors.black),
          Flexible(
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    onPressed: () {
                      context.read<ShoppingCart>().removeAll();
                    },
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrangeAccent)),
                    onPressed: () {
                      Navigator.pushNamed(context, "/checkout");
                    },
                    child: const Text("Checkout",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color:
                                Colors.white))), // added button for check out
              ]))),
          TextButton(
            child: const Text(
              "Go back to Product Catalog",
              style: TextStyle(
                  color: Colors.deepOrangeAccent, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/products");
            },
          ),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 80.0, bottom: 30), // Add space
            child: const Text(
              'There are no items in the cart yet!',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.food_bank),
                    title: Text(products[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        productname = products[index].name;
                        context.read<ShoppingCart>().removeItem(productname);

                        if (products.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$productname removed!"),
                            duration:
                                const Duration(seconds: 1, milliseconds: 100),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Cart Empty!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                        }
                      },
                    ),
                  );
                },
              )),
            ],
          ));
  }
}

Widget computeCost() {
  return Consumer<ShoppingCart>(builder: (context, cart, child) {
    return Text(
      "Total: ₱${cart.cartTotal}",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  });
}
