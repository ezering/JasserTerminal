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
      printer.printCustom("----------------------", 3, 1);
      printer.printNewLine();

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
      printer.printCustom("Test Imprimante", 0, 1);
      printer.printQRcode("Jasser Terminal", 200, 200, 1);
      printer.printNewLine();

      printer.printNewLine();

      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();

      printer.printNewLine();
      printer.printCustom("JASSER TERMINAL", 3, 1);
      printer.printNewLine();

      printer.printNewLine();
      printer.printNewLine();
      printer.paperCut();
    } else {
      Display.dialogError(context, "L'imprimante n'est pas connectée");
    }
  }
}
