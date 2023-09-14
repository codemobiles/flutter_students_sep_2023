import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class MyDialogBarCode extends StatelessWidget {
  const MyDialogBarCode({super.key});

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
              data: 'https://pub.dev/packages/barcode_widget', // Content
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
