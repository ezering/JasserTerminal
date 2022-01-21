import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';

class Printers extends ChangeNotifier {
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  bool _isPrinterConnected = false;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  List<BluetoothDevice> get devices {
    return [..._devices];
  }

  void getDevices() async {
    _devices = await printer.getBondedDevices();
    notifyListeners();
  }

  BluetoothDevice? get selectedDevice {
    return _selectedDevice;
  }

  BluetoothDevice? setSelectedDevice(BluetoothDevice? selectedDevice) {
    _selectedDevice = selectedDevice;
    notifyListeners();
    return selectedDevice;
  }

  bool get isPrinterConnected {
    return _isPrinterConnected;
  }

  bool setIsPrinterConnected(bool isPrinterConnected) {
    _isPrinterConnected = isPrinterConnected;
    notifyListeners();
    return isPrinterConnected;
  }
}
