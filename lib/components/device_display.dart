import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firebase_functionality.dart';
import './device_manage.dart';

class DeviceDisplay extends StatelessWidget {
  final String deviceName;
  final String documentId;
  final int temperature;
  final bool status;
  final newDeviceNameController = TextEditingController();
  final FirebaseFunctionality firebaseFunctionality = FirebaseFunctionality();
  DeviceDisplay(
      {this.documentId, this.deviceName, this.temperature, this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Dismissible(
        key: ValueKey(documentId),
        onDismissed: (direction) {
          firebaseFunctionality.deleteDevice(documentId);
        },
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("This item will be deleted"),
                    actions: <Widget>[
                      FlatButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          }),
                      FlatButton(
                          child: Text("Yes"),
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          }),
                    ],
                  ));
        },
        background: Container(
          padding: EdgeInsets.only(right: 20.0),
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        direction: DismissDirection.endToStart,
        child: ListTile(
          leading: GestureDetector(child: Icon(Icons.edit)),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return DeviceManage(
                  changeName: () {
                    firebaseFunctionality.changeName(
                        documentId, newDeviceNameController.text);
                    Navigator.of(context).pop();
                  },
                  nameDeviceController: newDeviceNameController,
                );
              },
            );
          },
          title: Text(deviceName),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(temperature.toString()),
              Switch.adaptive(
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
                inactiveTrackColor: Colors.red,
                value: status,
                onChanged: (bool newValue) {
                  firebaseFunctionality.turnOnOffDevice(documentId, newValue);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
