import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AdaptiveButton extends StatelessWidget {
  final Function onPress;
  final Widget child;

  AdaptiveButton({@required this.child, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? RaisedButton(child: child, onPressed: onPress)
        : Platform.isIOS
            ? CupertinoButton(
                color: Color.fromRGBO(141, 157, 127, 1),
                child: child,
                onPressed: onPress)
            : RaisedButton(child: child, onPressed: onPress);
  }
}
