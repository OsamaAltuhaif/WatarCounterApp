import 'package:flutter/material.dart';
import '/pages/chart_screen.dart';
import '/pages/home.dart';
import '/pages/reminder_settings_screen.dart';
import '/widgets/addWaterMills.dart';

// ignore: must_be_immutable
class TabBarItemWidget extends StatelessWidget {
  int currentItem;
  Color myColor;
  TabBarItemWidget(this.currentItem,this.myColor);


  @override
  Widget build(BuildContext context) {

    
  final _kTapPages = <Widget>[
    HomeScreen(),
    ChartScreen(),
       ReminderSettingsScreen(),
       AddWaterProccess()
  ];
    return Container(
      child: _kTapPages[currentItem],
    );
  }
}
