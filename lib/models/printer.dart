import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/commande.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/models/product.dart';
import 'package:jasser_terminal/providers/printers.dart';
import 'package:jasser_terminal/screens/printer/printer_screen.dart';
import 'package:provider/provider.dart';

class Printer {
  static void printListCommandes(
      BuildContext context, List<Commande> commandes) {
    BlueThermalPrinter printer = BlueThermalPrinter.instance;
    var isConnected =
        Provider.of<Printers>(context, listen: false).isPrinterConnected;

    if (isConnected) {
      printer.printCustom("JASSER TERMINAL", 3, 1);
      printer.printCustom("Liste pour fournisseur", 3, 1);
      printer.printCustom("**********************", 3, 1);

      for (var commande in commandes) {
        printer.printCustom((commande.product.name), 2, 1);
        // printer.printLeftRight("Prix:", "${commande.product.price} euros", 1,
        //     charset: "windows-1250");
        printer.printLeftRight(
            "Quantité:", "${commande.product.quantity}/unité", 1,
            charset: "windows-1250");

        printer.printNewLine();
      }
      printer.printNewLine();
      printer.printNewLine();
      printer.printCustom(
          "Nombres de produits: ${commandes.length} produits", 3, 1);
      printer.printCustom("JASSER TERMINAL", 3, 1);
      printer.printNewLine();
      printer.printNewLine();
      printer.paperCut();
    } else {
      Display.dialogError(context, "L'imprimante n'est pas connectée")
          .then((_) {
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ThermalPrinterScreen()));
      });
    }
  }

  static void printProduct(
      BuildContext context, Product product, dynamic qrCodedata) {
    BlueThermalPrinter printer = BlueThermalPrinter.instance;
    var isConnected =
        Provider.of<Printers>(context, listen: false).isPrinterConnected;
    if (isConnected) {
      printer.printCustom(product.name.toUpperCase(), 3, 1);

      printer.printLeftRight("Prix:", "${product.price} euros", 1,
          charset: "windows-1250");
      printer.printLeftRight("Quantité:", product.quantity, 1,
          charset: "windows-1250");

      printer.printNewLine();

      printer.printCustom(product.description, 1, 1);
      printer.printQRcode("$qrCodedata", 250, 250, 1);

      printer.printNewLine();
      printer.printNewLine();
      printer.paperCut();
    } else {
      Display.dialogError(context, "L'imprimante n'est pas connectée")
          .then((_) {
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ThermalPrinterScreen()));
      });
    }
  }

  static void printTest(BuildContext context) {
    BlueThermalPrinter printer = BlueThermalPrinter.instance;
    var isConnected =
        Provider.of<Printers>(context, listen: false).isPrinterConnected;
    if (isConnected) {
      printer.printCustom("Thermal Printer Demo", 0, 1);
      printer.printQRcode("Thermal Printer Demo", 200, 200, 1);
      printer.printNewLine();

      printer.printNewLine();

      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();

      printer.printNewLine();
      printer.printCustom("HEADER", 3, 1);
      printer.printNewLine();
      // printer.printImage(pathImage); //path of your image/logo
      printer.printNewLine();
      //printer.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      printer.printLeftRight("LEFT", "RIGHT", 0);
      printer.printLeftRight("LEFT", "RIGHT", 1);
      printer.printLeftRight("LEFT", "RIGHT", 1, format: "%-15s %15s %n");
      printer.printNewLine();
      printer.printLeftRight("LEFT", "RIGHT", 2);
      printer.printLeftRight("LEFT", "RIGHT", 3);
      printer.printLeftRight("LEFT", "RIGHT", 4);
      printer.printNewLine();
      printer.print3Column("Col1", "Col2", "Col3", 1);
      printer.print3Column("Col1", "Col2", "Col3", 1,
          format: "%-10s %10s %10s %n");
      printer.printNewLine();
      printer.print4Column("Col1", "Col2", "Col3", "Col4", 1);
      printer.print4Column("Col1", "Col2", "Col3", "Col4", 1,
          format: "%-8s %7s %7s %7s %n");
      printer.printNewLine();
      String testString = " čĆžŽšŠ-H-ščđ";
      printer.printCustom(testString, 1, 1, charset: "windows-1250");
      printer.printLeftRight("Številka:", "18000001", 1,
          charset: "windows-1250");
      printer.printCustom("Body left", 1, 0);
      printer.printCustom("Body right", 0, 2);
      printer.printNewLine();
      printer.printCustom("Thank You", 2, 1);
      printer.printNewLine();
      printer.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
      printer.printNewLine();
      printer.printNewLine();
      printer.paperCut();
    } else {
      // erreur ou allez à la page de configuration du printer
    }
  }
}
