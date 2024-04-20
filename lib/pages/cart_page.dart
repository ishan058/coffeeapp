import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/provider/coffee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/cart_tile.dart';
import '../components/my_button.dart';
import '../model/coffee.dart';


/*

CART PAGE

  - User can check their cart and remove items if necessary
  - User can tap 'Pay now' button $

*/

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // delete item from cart
  void removeItemFromCart(String id) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('cart').doc(id).delete();
  }

  // pay now button tapped
  void payNow() {
    /*

    integrate your payment services in this method

    */
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var cartData = ref.watch(cartDataProvider);
      return Column(
        children: [
          // heading
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 25, bottom: 25),
                child: Text(
                  'Your Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),

          cartData.when(
              data: (data) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      // get individual cart items
                      Coffee coffee = Coffee(name: data.docs[index]['name'], price: data.docs[index]['price'], imagePath: data.docs[index]['image']);

                      return CartTile(
                        coffee: coffee,
                        onPressed: () => removeItemFromCart(data.docs[index].id),
                      );
                    },
                  ),
                );
              },
              error: (e, r) => Text(e.toString()),
              loading: () => const SizedBox.shrink()),
          // list of cart items

          // pay button
          MyButton(text: "Pay now", onTap: payNow)
        ],
      );
    });
  }
}
