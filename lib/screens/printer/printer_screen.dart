import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/models/printer.dart';
import 'package:jasser_terminal/providers/printers.dart';
import 'package:provider/provider.dart';

class ThermalPrinterScreen extends StatefulWidget {
  static const String routeName = '/thermal-printer';

  const ThermalPrinterScreen({Key? key}) : super(key: key);

  @override
  State<ThermalPrinterScreen> createState() => _ThermalPrinterScreenState();
}

class _ThermalPrinterScreenState extends State<ThermalPrinterScreen> {
  bool _isInit = true;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      try {
        setState(() {
          Provider.of<Printers>(context, listen: false).getDevices();
        });
      } catch (e) {
        print(e);
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var printersProvider = Provider.of<Printers>(context, listen: false);
    var devices = printersProvider.devices;
    var selectedDevice = printersProvider.selectedDevice;
    var isPrinterConnected = printersProvider.isPrinterConnected;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuration imprimante"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshMethod(context),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    return ListTile(
                      title: Text(device.name ?? "Appareil non reconnu"),
                      subtitle: Text(device.address.toString()),
                      onTap: () {
                        setState(() {
                          selectedDevice = device;
                          printersProvider.setSelectedDevice(device);
                        });
                      },
                      selected: selectedDevice == device,
                    );
                  },
                ),
              ),
              (!isPrinterConnected)
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedDevice != null) {
                            printer.connect(selectedDevice!);
                            setState(() {
                              isPrinterConnected = true;
                              printersProvider.setIsPrinterConnected(true);
                            });
                          } else {
                            Display.dialogError(
                                context, "Veuillez selectionner un appareil");
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Connecter l'imprimante"),
                            SizedBox(width: 10),
                            Icon(Icons.bluetooth_connected),
                            Icon(Icons.print_rounded),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(height: 0),
              const SizedBox(height: 10),
              (isPrinterConnected)
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          printer.disconnect();
                          setState(() {
                            isPrinterConnected = false;
                            printersProvider.setIsPrinterConnected(false);
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Déconnecter l'imprimante"),
                            SizedBox(width: 10),
                            Icon(Icons.print_disabled_rounded),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(height: 0),
              const SizedBox(height: 10),
              (isPrinterConnected)
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () => Printer.printTest(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Imprimer"),
                            SizedBox(width: 10),
                            Icon(Icons.print_rounded),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(height: 0),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshMethod(BuildContext context) async {
    setState(() {
      Provider.of<Printers>(context, listen: false).getDevices();
      Provider.of<Printers>(context, listen: false)
          .setIsPrinterConnected(false);
    });

    return;
  }

  Future<bool> printerConnexionState() async {
    var connexionState = await printer.isConnected;
    if (connexionState == true) {
      Provider.of<Printers>(context, listen: false).setIsPrinterConnected(true);

      return true;
    } else {
      Provider.of<Printers>(context, listen: false)
          .setIsPrinterConnected(false);

      return false;
    }
  }
}
