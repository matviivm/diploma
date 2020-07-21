import 'package:flutter/material.dart';

class Strings {
  static const String login = "LOGIN";
  static const String registration = "REGISTRATION";
  static const String passwordValidation =
      "Password must contains more than 8 char";
  static const String emailValidation = "Please input correct email";
  static const String tryAgain = "Try again";
  static const String signUp = "Sign up";
  static const String log = "Login";
  static const String applicationName = "SmartSocket";
  static const String questionAboutAccount = 'Already have an account?';
  static const String manageDevice = "Device manage";
  static const String hintChangeName = "change Name";
  static const String hintEmail = "Email";
  static const String hintPassword = "Password";
  static const String deviceNotFound = "Device not found";
  static const String home = "Home";
  static const String addDevice = "Add device";
}

class Style {
  static const TextStyle applicationName =
      TextStyle(fontSize: 36.0, color: Color.fromRGBO(192, 195, 189, 1));

  static const TextStyle signUpStyle = TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(141, 157, 127, 1));

  static const TextStyle buttonTextStyle = TextStyle(color: Colors.white);

  static const TextStyle signInStyle = TextStyle(
      decoration: TextDecoration.underline,
      color: Color.fromRGBO(141, 157, 127, 1),
      fontSize: 20.0);

  static const TextStyle questionAboutAccountStyle =
      TextStyle(color: Color.fromRGBO(192, 195, 189, 1));

  static const TextStyle errorMessageStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0);
}
