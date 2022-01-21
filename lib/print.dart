import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

class ThermalPrintScreen extends StatefulWidget {
  static const String routeName = '/thermal-print';

  const ThermalPrintScreen({Key? key}) : super(key: key);

  @override
  State<ThermalPrintScreen> createState() => _ThermalPrintScreenState();
}

class _ThermalPrintScreenState extends State<ThermalPrintScreen> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    super.initState();
    getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Printer Demo"),
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton<BluetoothDevice>(
              value: selectedDevice,
              hint: const Text("Select Printer"),
              onChanged: (device) => setState(() => selectedDevice = device),
              items: devices.map((device) {
                return DropdownMenuItem(
                  child: Text(device.name!),
                  value: device,
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  printer.connect(selectedDevice!);
                },
                child: const Text("Connect")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  printer.disconnect();
                },
                child: const Text("Disconnect")),
            ElevatedButton(
              onPressed: () async {
                if ((await printer.isConnected)!) {
                  printer.printNewLine();
                  //SIZE

                  //0: Normal text
                  //1: Normal text bold
                  //2: Medium text bold
                  //3: Large text bold

                  //ALIGN

                  //0: Left
                  //1: Center
                  //2: Right
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
                  printer.printLeftRight("LEFT", "RIGHT", 1,
                      format: "%-15s %15s %n");
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
                  printer.printCustom(testString, 1, 1,
                      charset: "windows-1250");
                  printer.printLeftRight("Številka:", "18000001", 1,
                      charset: "windows-1250");
                  printer.printCustom("Body left", 1, 0);
                  printer.printCustom("Body right", 0, 2);
                  printer.printNewLine();
                  printer.printCustom("Thank You", 2, 1);
                  printer.printNewLine();
                  printer.printQRcode(
                      "Insert Your Own Text to Generate", 200, 200, 1);
                  printer.printNewLine();
                  printer.printNewLine();
                  printer.paperCut();
                }
              },
              child: const Text('Print'),
            )
          ],
        ),
      ),
    );
  }

  void getDevices() async {
    devices = await printer.getBondedDevices();
    setState(() {});
  }
}
