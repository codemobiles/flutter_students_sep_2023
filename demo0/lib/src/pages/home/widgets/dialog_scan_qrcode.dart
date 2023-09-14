import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DialogScanQRCode extends StatefulWidget {
  const DialogScanQRCode({Key? key}) : super(key: key);

  @override
  _DialogScanQRCodeState createState() => _DialogScanQRCodeState();
}

class _DialogScanQRCodeState extends State<DialogScanQRCode> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(code),
            SizedBox(height: 12),
            Stack(
              alignment: Alignment.center,
              children: [
                _buildQRView(),
                Container(
                  color: Colors.yellow,
                  width: double.infinity,
                  height: 1,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  width: 80,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.black26,
                    child: Text(
                      "Debug",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('close'),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox _buildQRView() => SizedBox(
        height: 300,
        child: QRView(
          key: _qrKey,
          onQRViewCreated: (QRViewController controller) {
            controller.scannedDataStream.listen((scanData) {
              controller.stopCamera();
              setState(() {
                code = scanData.code!;
              });
            });
          },
        ),
      );
}
