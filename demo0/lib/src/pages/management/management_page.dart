import 'dart:io';

import 'package:demo0/src/models/product.dart';
import 'package:demo0/src/widgets/custom_flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final _form = GlobalKey<FormState>();
  var _product = Product(name: "productX", price: 10, stock: 20);
  var _editMode = false;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Product) {
      _product = arguments;
      _editMode = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Management'),
        actions: [
          IconButton(
              onPressed: () {
                _form.currentState?.save();
                CustomFlushbar.showSuccess(context,
                    message:
                        "${_product.name}, ${_product.stock}, ${_product.price}, ");
              },
              icon: const Icon(Icons.upload))
        ],
      ),
      body: Container(
        height: 400,
        padding: EdgeInsets.all(30),
        child: Card(
          elevation: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  // Name
                  TextFormField(
                    decoration: _inputStyle("Name"),
                    onSaved: (newValue) {
                      _product.name = newValue ?? "";
                    },
                  ),
                  const SizedBox(height: 10),
                  // Price
                  TextFormField(
                      decoration: _inputStyle("Price"),
                      onSaved: (newValue) {
                        _product.price = int.parse(newValue ?? "0");
                      }),
                  const SizedBox(height: 10),
                  // Stock
                  TextFormField(
                      decoration: _inputStyle("Stock"),
                      onSaved: (newValue) {
                        _product.stock = int.parse(newValue ?? "0");
                      }),
                ],
              ),
            ),
          ),
        ),
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
}
