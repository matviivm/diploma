import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './adaptive_button.dart';
import '..//../constants.dart';

class Registration extends StatefulWidget {
  final void Function(
          String email, String password, bool isLogin, BuildContext context)
      submitForm;

  Registration({this.submitForm});

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _email;
  String _password;
  String _confirmPassword;
  var _passwordController = TextEditingController();
  var _confirmpasswordController = TextEditingController();
  bool _isLogin = false;
  final _formKey = GlobalKey<FormState>();
  var _passwordFocusNode = FocusNode();
  var _confirmPasswordFocusNode = FocusNode();

  void _trySubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();
      widget.submitForm(_email.trim(), _password.trim(), _isLogin, context);
    }
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _isLogin ? "Login" : "Create new account",
            style: Style.signUpStyle,
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: Strings.hintEmail),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (emailValid == false) {
                        return Strings.emailValidation;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: Strings.hintPassword),
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_confirmPasswordFocusNode);
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value.length < 8) {
                        return Strings.passwordValidation;
                      }
                      return null;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Confirm password"),
                      textInputAction: TextInputAction.done,
                      controller: _confirmpasswordController,
                      obscureText: true,
                      focusNode: _confirmPasswordFocusNode,
                      onSaved: (value) {
                        _confirmPassword = value;
                      },
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "Password must be equal";
                        }
                        return null;
                      },
                    )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          AdaptiveButton(
            child: Text(_isLogin ? "Login" : "Create new account",
                style: Style.buttonTextStyle),
            onPress: () {
              _trySubmit();
            },
          ),
          Text(
            _isLogin
                ? "Do you want to create a new account?"
                : Strings.questionAboutAccount,
            style: Style.questionAboutAccountStyle,
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                _isLogin = !_isLogin;
              });
            },
            child: _isLogin
                ? Text("Sign up", style: Style.signInStyle)
                : Text(
                    'Sign in',
                    style: Style.signInStyle,
                  ),
          ),
        ],
      ),
    );
  }
}
