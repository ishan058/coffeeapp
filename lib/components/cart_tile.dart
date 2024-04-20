import 'package:flutter/material.dart';
import '../model/coffee.dart';

/*

CART TILE

This is the tile seen on the coffee order page.
User can remove from cart by tapping the tile.


*/

class CartTile extends StatelessWidget {
  final Coffee coffee;
  void Function()? onPressed;
  CartTile({
    super.key,
    required this.coffee,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        leading: Image.network(coffee.imagePath),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            coffee.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text('\$${coffee.price}'),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.brown[300],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
