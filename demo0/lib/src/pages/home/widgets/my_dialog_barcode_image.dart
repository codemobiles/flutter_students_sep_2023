import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class MyDialogBarCode extends StatelessWidget {
  const MyDialogBarCode({required this.code, super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarcodeWidget(
              barcode: Barcode.code128(),
              data: code, // Content
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
