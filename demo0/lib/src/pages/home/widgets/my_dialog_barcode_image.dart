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
          children: [
            BarcodeWidget(
              barcode: Barcode.aztec(), // Barcode type and settings
              data: 'https://pub.dev/packages/barcode_widget', // Content
              width: 200,
              height: 200,
            ),
            SizedBox(height: 10),
            Text("1234"),
          ],
        ),
      ),
    );
  }
}
