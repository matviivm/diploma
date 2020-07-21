import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

import '../constants.dart';

class AdaptiveBottomNavigationBar extends StatelessWidget {
  final int index;
  final Function onTap;

  AdaptiveBottomNavigationBar({@required this.index, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? BottomNavigationBar(
            currentIndex: index,
            selectedItemColor: Colors.green,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(Strings.home),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text(Strings.addDevice),
              ),
            ],
          )
        : Platform.isIOS
            ? CupertinoTabBar(
                currentIndex: index,
                onTap: onTap,
                activeColor: Colors.green,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    title: Text(Strings.home),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.add),
                    title: Text(Strings.addDevice),
                  ),
                ],
              )
            : BottomNavigationBar(
                currentIndex: index,
                selectedItemColor: Colors.green,
                onTap: onTap,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text(Strings.home),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    title: Text(Strings.addDevice),
                  ),
                ],
              );
  }
}
