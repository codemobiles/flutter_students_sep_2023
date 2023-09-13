import 'package:demo0/src/constants/network_api.dart';
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
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name),
              Text("${product.price} บาท"),
              Container(
                color: Colors.black,
                height: 210,
                width: double.infinity,
                child: Image.network("${NetworkAPI.imageURL}/${product.image}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
