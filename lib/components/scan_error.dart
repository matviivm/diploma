import 'package:flutter/material.dart';

import '../constants.dart';

class ScanError extends StatelessWidget {
  final String errorMessage;
  final Function scanFunction;

  ScanError({@required this.scanFunction, @required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(errorMessage,
                textAlign: TextAlign.center, style: Style.errorMessageStyle),
            RaisedButton(
              child: Text(Strings.tryAgain),
              onPressed: scanFunction,
            ),
          ],
        ),
      ),
    );
  }
}
