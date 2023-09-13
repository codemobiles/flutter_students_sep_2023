import 'dart:io';

import 'package:demo0/src/app.dart';
import 'package:demo0/src/constants/network_api.dart';
import 'package:demo0/src/models/product.dart';
import 'package:demo0/src/widgets/custom_flushbar.dart';
import 'package:demo0/src/widgets/image_not_found.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    required this.product,
    this.onTap,
    this.isGrid,
    Key? key,
  }) : super(key: key);

  final Product product;
  final VoidCallback? onTap;
  final bool? isGrid;

  @override
  State<ProductItem> createState() => ProductItemState();
}

class ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: widget.onTap,
      child: LayoutBuilder(
        builder: (context, constraint) => Card(
          color: Colors.white,
          child: Column(
            children: [
              _buildImage(constraint.maxHeight),
              _buildInfo(),
            ],
          ),
        ),
      ),
    );
  }

  show() {
    CustomFlushbar.showSuccess(context, message: widget.product.name);
  }

  Stack _buildImage(double maxHeight) {
    // caes of listview
    var height = maxHeight * 0.7;

    // case of grid
    if (widget.isGrid != null && widget.isGrid == true) {
      height = maxHeight * 0.6;
    }

    final image = widget.product.image;
    final stock = widget.product.stock;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: image != null && image.isNotEmpty
              ? _image(image)
              : ImageNotFound(),
        ),
        if (stock <= 0) _buildOutOfStock(),
      ],
    );
  }

  Expanded _buildInfo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: (widget.isGrid ?? false)
                    ? const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal)
                    : const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '฿${formatCurrency.format(widget.product.price)}',
                    style: TextStyle(
                      fontSize: widget.isGrid ?? false
                          ? getSubtitleFontSizeForGrid()
                          : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${formatNumber.format(widget.product.stock)} pieces',
                    style: TextStyle(
                      fontSize: widget.isGrid ?? false
                          ? getSubtitleFontSizeForGrid()
                          : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  double getSubtitleFontSizeForGrid() {
    return Platform.isAndroid ? 15 : 12;
  }

  Image _image(String image) {
    String imageUrl;
    if (image.contains("://")) {
      imageUrl = image;
    } else {
      imageUrl = '${NetworkAPI.imageURL}/$image';
    }

    return Image.network(
      imageUrl,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Positioned _buildOutOfStock() => const Positioned(
        top: 2,
        right: 2,
        child: Card(
          color: Colors.amber,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              'out of stock',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );
}
