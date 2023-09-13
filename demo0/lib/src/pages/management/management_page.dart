import 'dart:io';

import 'package:demo0/src/bloc/management/management_bloc.dart';
import 'package:demo0/src/models/product.dart';
import 'package:demo0/src/pages/management/widgets/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  _ManagementPageState createState() => _ManagementPageState();
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
      _testLog();
    }

    return Scaffold(
      appBar: AppBar(title: Text("Management"), actions: [
        IconButton(
            icon: Icon(Icons.upload),
            onPressed: () =>
                context.read<ManagementBloc>().add(ManagementEventSubmit(
                      product: _product,
                      image: _imageFile,
                      isEditMode: _editMode,
                      form: _form,
                    ))),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ProductForm(
            _product,
            callBackSetImage: _callBackSetImage,
            formKey: _form,
            deleteProduct: _editMode ? _deleteProduct : null,
          ),
        ),
      ),
    );
  }

  void _deleteProduct() {
    context.read<ManagementBloc>().add(ManagementEventDelete(_product.id!));
  }

  void _callBackSetImage(File? imageFile) {
    _imageFile = imageFile;
  }

  void _testLog() {
    logger.d(_product.name);
  }
}
