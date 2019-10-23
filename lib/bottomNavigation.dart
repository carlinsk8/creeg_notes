import 'package:flutter/material.dart';

import 'package:note_creeg/home.dart';
import 'package:note_creeg/task.dart';
import 'util.dart';


class BottomNavigationBarApp extends StatelessWidget {
  final int bottomNavigationBarIndex;
  final BuildContext context;

  const BottomNavigationBarApp(this. context, this.bottomNavigationBarIndex);

  void onTabTapped(int index) {
    Navigator.of(context).push(
      MaterialPageRoute<Null>(builder: (BuildContext context) {
        return (index == 1) ? Task() : Home();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: bottomNavigationBarIndex,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
      selectedLabelStyle: TextStyle(color: CustomColors.BlueDark),
      selectedItemColor: CustomColors.BlueDark,
      unselectedFontSize: 10,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Icon(Icons.home),
          ),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Icon(Icons.list),
          ),
          title: Text('Task'),
        ),
      ],
      onTap: onTabTapped,
    );
  }
}
