import 'package:flutter/material.dart';
import '../models/water_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'dart:convert';

class WaterProvider with ChangeNotifier {
  int _goal = 2000; // الهدف الافتراضي
  List<WaterEntry> _entries = [];

  int get goal => _goal;
  List<WaterEntry> get entries => _entries;

  int get totalIntakeToday {
    final today = DateTime.now();
    return _entries
        .where((entry) =>
            entry.date.day == today.day &&
            entry.date.month == today.month &&
            entry.date.year == today.year)
        .fold(0, (sum, entry) => sum + entry.quantity);
  }

  void setGoal(int newGoal) {
    _goal = newGoal;
    notifyListeners();
  }

  void addEntry(int quantity) {
    _entries.add(WaterEntry(date: DateTime.now(), quantity: quantity));
    _saveData();
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _entries
        .map((entry) =>
            {'date': entry.date.toIso8601String(), 'quantity': entry.quantity})
        .toList();
    prefs.setString('water_entries', json.encode(data));
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('water_entries');
    if (data != null) {
      _entries = (json.decode(data) as List)
          .map((item) => WaterEntry(
              date: DateTime.parse(item['date']), quantity: item['quantity']))
          .toList();
      notifyListeners();
    }
  }

// دالة لتحضير بيانات الرسم البياني
  List<charts.Series<WaterEntry, String>> getChartData() {
    // إعداد البيانات اليومية
    Map<String, int> dailyData = {};
    for (var entry in _entries) {
      final date = "${entry.date.year}-${entry.date.month}-${entry.date.day}";
      dailyData[date] = (dailyData[date] ?? 0) + entry.quantity;
    }

    // تحويل البيانات إلى قائمة
    final chartData = dailyData.entries
        .map((e) => WaterEntry(
              date: DateTime.parse(e.key),
              quantity: e.value,
            ))
        .toList();

    // الهدف اليومي (يمكنك ضبطه بناءً على إعدادات المستخدم)
    final _goal = 2000; // مثال: 2000 مل (2 لتر)

    // إعداد البيانات للرسم البياني مع الخط المرجعي للهدف
    return [
      charts.Series<WaterEntry, String>(
        id: 'Water',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WaterEntry entry, _) =>
            "${entry.date.day}/${entry.date.month}",
        measureFn: (WaterEntry entry, _) => entry.quantity,
        data: chartData,
      ),
      charts.Series<WaterEntry, String>(
        id: 'Goal',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (WaterEntry entry, _) =>
            "${entry.date.day}/${entry.date.month}",
        measureFn: (WaterEntry entry, _) => _goal,
        data: chartData,
      )..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}
