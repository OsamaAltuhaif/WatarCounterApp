import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/TabBarsButtions.dart';
import 'models/water_provider.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static int _currentTabIndex = 0;
  final _kBottomNavItem = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      
      icon: Icon(
        Icons.home,
        color: Colors.blue,
      ),
      label: 'الرئيسية',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.bar_chart,
        color: Colors.blue,
      ),
      label: 'التحليلات',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.watch_later,
          color: Colors.blue,
        ),
        label: 'الإعدادات'),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add,
        color: Colors.blue,
      ),
      label: 'إضافة',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WaterProvider()..loadData(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'ElMessiri'
        ),
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                items: _kBottomNavItem,
                selectedFontSize: 20,
                selectedItemColor: Colors.blue,
                currentIndex: _currentTabIndex,
                onTap: (index) {
                  setState(() {
                    _currentTabIndex = index;
                  });
                }),
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              title: Text(
                'عداد شرب الماء',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            body: TabBarItemWidget(_currentTabIndex, Colors.white),
          ),
        ),
      ),
    );
  }
}
