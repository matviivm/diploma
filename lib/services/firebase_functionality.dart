import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseFunctionality {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String errorMessage, errorLoginMessage;
  var user, existingUser;
  FirebaseUser currentUser;

  Future registration({String email, String password}) async {
    try {
      user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Account Exist";
          break;
      }
    }
    return user;
  }

  String existAccount() {
    return errorMessage;
  }

  Future login({String email, String password}) async {
    try {
      existingUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          errorLoginMessage = "User not found";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorLoginMessage = "Wrong password";
          break;
      }
    }
    if (errorLoginMessage != null) {
      return errorLoginMessage;
    }
    return existingUser;
  }

  String loginUnSuccess() {
    return errorLoginMessage;
  }
  Future addDevice(String idDevice) async {
    currentUser = await _auth.currentUser();
    _firestore.collection('devices').document(idDevice).updateData({"owner": "${currentUser.uid}"});
  }

  void turnOnOffDevice(String idDevice, bool status)  {
    _firestore.collection('devices').document(idDevice).updateData({"status": status});
  }
  void changeName(String idDevice, String newName)  {
    _firestore.collection('devices').document(idDevice).updateData({"customName": newName});
  }

  Future<void> deleteDevice(String idDevice) async {
    _firestore.collection('devices').document(idDevice).delete();
  }

  Future getUid() async {
    currentUser = await _auth.currentUser();
    if (currentUser.uid == null) {
      return;
    }
    return currentUser.uid;
  }
}


