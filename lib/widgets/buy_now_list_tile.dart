import 'package:flutter/material.dart';

class BuyNowListTile extends StatelessWidget {
  final String title;
  final Widget? leading;

  const BuyNowListTile({super.key, required this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: leading,
        trailing: ElevatedButton.icon(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Color(0xffc2daf8)),
            foregroundColor: MaterialStatePropertyAll<Color>(Color(0xff0888fd)) 
          ),
          onPressed: () {
            // TODO: order medicine
          },
          icon: const Icon(Icons.shopping_cart_outlined),
          label: const Text("Ordina"),
        ));
  }
}