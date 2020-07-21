import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DeviceManage extends StatelessWidget {
  final Function changeName;
  final nameDeviceController;

  DeviceManage(
      {@required this.changeName,
      @required this.nameDeviceController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(child: Text("Device Manage")),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: Strings.hintChangeName),
                    controller: nameDeviceController,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      icon: Center(
                        child: Icon(Icons.edit_attributes,
                            size: 45.0, color: Colors.green),
                      ),
                      onPressed: changeName),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
