import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderSettingsScreen extends StatefulWidget {
  @override
  _ReminderSettingsScreenState createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  int _reminderInterval = 60; // الافتراضي: كل 60 دقيقة

  @override
  void initState() {
    super.initState();
    _loadReminderInterval();
  }

  Future<void> _loadReminderInterval() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _reminderInterval = prefs.getInt('reminderInterval') ?? 60;
    });
  }

  Future<void> _saveReminderInterval(int interval) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('reminderInterval', interval);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'اختر فترة التذكير:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue, shadows: [
                  BoxShadow(color: Colors.black, blurRadius: 1, offset: Offset(1, 0))
                ] ),
              ),
                          SizedBox(width: 1,),
      
              DropdownButton<int>(
                value: _reminderInterval,
                items: [1, 5, 15, 30, 60, 120].map((interval) {
                  return DropdownMenuItem<int>(
                    value: interval,
                    child: Text('$intervalدقيقة'),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _reminderInterval = newValue!;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تفعيل التذكير بشرب الماء!')),
            );
                  });
                  _saveReminderInterval(newValue!);
                },
              ),
              SizedBox(width: 1,),
              
            ],
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          
        ],
      ),
    );
  }
}
