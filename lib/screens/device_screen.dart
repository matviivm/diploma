import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/device_display.dart';
import '../services/firebase_functionality.dart';

class DeviceScreen extends StatefulWidget {
  static String id = "device_screen";

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final _firestore = Firestore.instance;
  FirebaseFunctionality _firebaseFunctionality = FirebaseFunctionality();
  var _newDeviceName = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(192, 195, 189, 1),
          centerTitle: true,
          title: Text("Smart Socket"),
          actions: [
            FlatButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app),
              label: Text("Logout"),
            )
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, futureShapshot) {
              if (futureShapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StreamBuilder(
                stream: _firestore
                    .collection('devices')
                    .where('owner',
                        isEqualTo: futureShapshot.data.uid.toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  final devicesDocuments =
                      snapshot.data == null ? null : snapshot.data.documents;
                  return ListView.builder(
                    itemCount:
                        devicesDocuments == null ? 0 : devicesDocuments.length,
                    itemBuilder: (ctx, index) => DeviceDisplay(
                      documentId: devicesDocuments[index].documentID,
                      deviceName: devicesDocuments[index]['customName'],
                      temperature: devicesDocuments[index]['temperature'],
                      status: devicesDocuments[index]['status'],
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: kIsWeb
            ? FloatingActionButton(
                backgroundColor: Color.fromRGBO(192, 195, 189, 1),
                child: Icon(Icons.add),
                onPressed: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Add new device"),
                          content: TextField(
                            decoration:
                                InputDecoration(labelText: "Input ID device"),
                            controller: _newDeviceName,
                          ),
                          actions: [
                            FlatButton(
                              color: Color.fromRGBO(192, 195, 189, 1),
                              child: Text("Update"),
                              onPressed: () {
                                _firebaseFunctionality
                                    .addDevice(_newDeviceName.text);
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              color: Color.fromRGBO(192, 195, 189, 1),
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              )
            : null,
      ),
    );
  }
}
