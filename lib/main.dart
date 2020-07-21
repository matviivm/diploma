import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'screens/device_screen.dart';
import 'screens/indicators_screen.dart';
import 'screens/registration_screen.dart';

void main() {
  // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(SmartSocket());
}

class SmartSocket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          minWidth: 200,
          buttonColor: Color.fromRGBO(141, 157, 127, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return kIsWeb ? DeviceScreen() : IndicatorsScreen();
          }
          return RegistrationScreen();
        },
      ),
      routes: {
        RegistrationScreen.id: (context) => RegistrationScreen(),
        IndicatorsScreen.id: (context) => IndicatorsScreen(),
        DeviceScreen.id: (context) => DeviceScreen()
      },
    );
  }
}
