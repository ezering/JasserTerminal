import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/models/shelf.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:jasser_terminal/screens/product/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  static const routeName = '/scan';

  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () => scanQR());
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    late Shelf _shelf;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      try {
        var barcodeData = json.decode(barcodeScanRes);
        String productId = barcodeData['id'] as String;
        String shelfId = barcodeData['shelfId'] as String;
        String shopId = barcodeData['shopId'] as String;

        if (productId.isNotEmpty && shelfId.isNotEmpty && shopId.isNotEmpty) {
          setState(() {
            _isLoading = true;
          });
          await Provider.of<Shelfs>(context, listen: false)
              .findShelfById(shelfId)
              .then((value) {
            setState(() {
              _isLoading = false;
            });
            return _shelf = value;
          });

          setState(() {
            _isLoading = true;
          });
          await Provider.of<Products>(context, listen: false)
              .fetchAndSetProducts(_shelf)
              .then((value) => setState(() {
                    _isLoading = false;
                  }));
          Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: {
            'productId': productId,
            'shelfId': shelfId,
            'shopId': shopId,
          });
        }
      } catch (e) {
        if (e.toString().contains("NoSuchMethodError")) {
          Display.dialogError(
              context, "Erreur, le QR code ne correspond à aucun produit");
        }
      }
    } on PlatformException {
      barcodeScanRes = 'Une erreur est survenue';
    }

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Une erreur est survenue';
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  alignment: Alignment.center,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // ElevatedButton(
                      //     onPressed: () => scanBarcodeNormal(),
                      //     child: const Text('Code barre normal')),
                      ElevatedButton(
                          onPressed: () => scanQR(),
                          child: const Text('Qr code')),
                      // Text('Résultat du scan : $_scanBarcode\n',
                      //     style: const TextStyle(fontSize: 20))
                    ],
                  ),
                );
        },
      ),
    );
  }
}
