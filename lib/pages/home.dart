import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '/models/water_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final waterProvider = Provider.of<WaterProvider>(context);
    final progress = waterProvider.totalIntakeToday / waterProvider.goal;

    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 5,
                //height: 250,
                child: Lottie.asset('assets/images/water.json')),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'هدفك اليومي: ${waterProvider.goal} مل',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        shadows: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 1.5,
                              offset: Offset(0.6, 0.5))
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Card(
                  elevation: 5,
                  child: CircularProgressIndicator(
                  
                    value: progress,
                    strokeWidth: 65,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                   // minHeight: 10,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'شربت اليوم: ${waterProvider.totalIntakeToday} مل',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        shadows: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 1.5,
                              offset: Offset(0.6, 0.5))
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}



