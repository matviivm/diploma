import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import '../services/firebase_functionality.dart';
import '../components/scan_error.dart';
import '../screens/device_screen.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  FirebaseFunctionality _firebaseFunctionality = FirebaseFunctionality();
  String _idDevice;
  String _errorMessage;

  @override
  void initState() {
    scan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _errorMessage != null
          ? ScanError(
              scanFunction: scan,
              errorMessage: _errorMessage,
            )
          : Scaffold(),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      this._idDevice = barcode;
      _firebaseFunctionality.addDevice(this._idDevice);
      Navigator.of(context).pushReplacementNamed(DeviceScreen.id);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._errorMessage = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this._errorMessage = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this._errorMessage =
          'User returned using the "back"-button before scanning anything');
    } catch (e) {
      setState(() => this._errorMessage = 'Unknown error: $e');
    }
  }
}
