import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../Widget/ButtonWidget.dart';
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {

  String qrCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "QR Code Scanner",
          style: TextStyle(fontFamily: "Sofia"),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Scan Result',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ) ,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$qrCode',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ) ,
            ),
            SizedBox(
              height: 50,
            ),
            ButtonWidget (
              color: Colors.black26,
              text: 'Scan Qr Code',
              onClicked: () => scanQrCode(),
            )
          ],
        ),
      ),
    );
  }
  Future <void> scanQrCode() async{
    try{
      final qrCode =  await FlutterBarcodeScanner.scanBarcode(
        '#5fa693',
        'cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode.isEmpty ? '' : qrCode == '-1'
            ? ''
            : qrCode;
      });
    } on PlatformException{
      qrCode = 'Failed to get platform version';
    }
  }
}
