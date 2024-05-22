// this contains the code for the checkout screen

import 'package:flutter/material.dart';
import 'package:my_app/screen/my_cart.dart' show computeCost;
import 'package:provider/provider.dart';
import '../provider/shoppingcart_provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<ShoppingCart>();
    final cartItems = cart.cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text("Checkout"),
      ),
      body: cartItems.isEmpty // if the cart is empty,
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No items in the cart to checkout!", // show error text
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child:
                        computeCost(), // display total price ( 0 if there are no items in cart)
                  ),
                  SizedBox(height: 50),
                  const Divider(height: 4, color: Colors.black),
                  SizedBox(height: 50),
                  ElevatedButton(
                    // go back to catalog
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    onPressed: () {
                      Navigator.pushNamed(context, "/products");
                    },
                    child: const Text(
                      "Go back",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          // else, if cart is not empty,
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Items in Cart:", // display the items in cart
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text(item.name),
                        trailing: Text(
                          "₱${item.price.toString()}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: computeCost(), // and the total price
                ),
                SizedBox(height: 20),
                const Divider(height: 4, color: Colors.black),
                Flexible(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        // pay now button
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepOrangeAccent)),
                        onPressed: () {
                          cart.cartTotal = 0; // set total to 0
                          cart.removeAll(); // remove all items from cart
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Payment Successful!"), //show message in snackbar
                              duration: Duration(seconds: 1, milliseconds: 100),
                            ),
                          );
                        },
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
