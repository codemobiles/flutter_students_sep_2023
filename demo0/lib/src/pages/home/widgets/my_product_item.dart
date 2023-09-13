import 'package:demo0/src/models/product.dart';
import 'package:flutter/material.dart';

class MyProductItem extends StatelessWidget {
  const MyProductItem({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(product.name),
        ),
      ),
    );
  }
}
