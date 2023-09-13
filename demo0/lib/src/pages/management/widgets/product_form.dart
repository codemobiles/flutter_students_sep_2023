import 'dart:io';

import 'package:demo0/src/models/product.dart';
import 'package:demo0/src/pages/management/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductForm extends StatefulWidget {
  final Product product;
  final Function(File? file) callBackSetImage;
  final Function? deleteProduct;
  final GlobalKey<FormState> formKey;

  ProductForm(
    this.product, {
    required this.callBackSetImage,
    required this.formKey,
    this.deleteProduct,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _spacing = 8.0;

  final _picker = ImagePicker();

  File? _file;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          _buildNameInput(),
          SizedBox(height: _spacing),
          Row(
            children: <Widget>[
              Flexible(
                child: _buildPriceInput(),
              ),
              SizedBox(width: _spacing),
              Flexible(
                child: _buildStockInput(),
              ),
            ],
          ),
          // ignore: dead_code
          if (false) _buildDemoBottomSheet(context),
          if (_file != null) SizedBox(height: 50, child: Image.file(_file!)),
          ProductImage(
            widget.callBackSetImage,
            image: widget.product.image,
          ),
          const SizedBox(height: 28),
          if (widget.deleteProduct != null) _buildDeleteButton(context),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  InputDecoration _inputStyle(String label) => InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        errorText: false ? 'Value Can\'t Be Empty' : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        labelText: label,
      );

  TextFormField _buildNameInput() => TextFormField(
        initialValue: widget.product.name,
        decoration: _inputStyle('name'),
        onSaved: (String? value) {
          widget.product.name = value ?? "";
        },
      );

  TextFormField _buildPriceInput() => TextFormField(
        initialValue: widget.product.price.toString(),
        decoration: _inputStyle('price'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          var price = 0;
          if (value != null && value.isNotEmpty) {
            price = int.parse(value);
          }
          widget.product.price = price;
        },
      );

  TextFormField _buildStockInput() => TextFormField(
        initialValue: widget.product.stock.toString(),
        decoration: _inputStyle('stock'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          var stock = 0;
          if (value != null && value.isNotEmpty) {
            stock = int.parse(value);
          }
          widget.product.stock = stock;
        },
      );

  FloatingActionButton _buildDeleteButton(BuildContext context) =>
      FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _delete(context),
        child: Icon(Icons.delete_outlined),
      );

  void _delete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text(
                'ok',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                widget.deleteProduct!();
              },
            ),
          ],
        );
      },
    );
  }

  _buildDemoBottomSheet(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: Icon(Icons.camera),
                        title: Text("Browse camera"),
                        onTap: () async {
                          final result = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {
                            _file = File(result!.path);
                          });
                        },
                      ),
                      const ListTile(
                        leading: Icon(Icons.photo),
                        title: Text("Browse photo"),
                      ),
                    ],
                  ));
            },
          );
        },
        child: Text("Browse"));
  }
}
