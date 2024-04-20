import 'package:coffeeapp/provider/coffee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/coffee_tile.dart';
import '../model/coffee.dart';
import 'coffee_order_page.dart';

/*

SHOP PAGE

User can browse the coffees that are for sale

*/

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // coffee page
  void goToCoffeePage(Coffee coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeeOrderPage(
          coffee: coffee,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var coffeeData = ref.watch(coffeeDataProvider);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading
          const Padding(
            padding: EdgeInsets.only(left: 25.0, top: 25),
            child: Text(
              'Coffee menu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // list of coffee

          coffeeData.when(
              data: (data) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      // get individual coffee
                      String name = data.docs[index]['name'];
                      String image = data.docs[index]['image'];
                      String price = data.docs[index]['price'];

                      return CoffeeTile(
                        name: name,
                        image: image,
                        price: price,
                        onPressed: () => goToCoffeePage(Coffee(name: name, price: price, imagePath: image)),
                      );
                    },
                  ),
                );
              },
              error: (e, r) => Text(e.toString()),
              loading: () => SizedBox.shrink()),
        ],
      );
    });
  }
}
