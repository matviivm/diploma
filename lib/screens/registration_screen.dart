import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smart_socket/components/registration.dart';
import 'package:smart_socket/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
      String email, String password, bool isLogin, BuildContext ctx) async {
    AuthResult authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on PlatformException catch (error) {
      var message = 'An error occurred. please check yout credentials';
      if (error.message != null) {
        message = error.message;
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: kIsWeb
                ? Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(Strings.applicationName,
                              style: Style.applicationName),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Registration(
                          submitForm: _submitAuthForm,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(Strings.applicationName,
                            style: Style.applicationName),
                      ),
                      Expanded(
                        flex: 6,
                        child: Registration(
                          submitForm: _submitAuthForm,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
