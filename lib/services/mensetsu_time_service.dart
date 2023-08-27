import 'package:flutter/material.dart';

class MensetsuTimeService extends ChangeNotifier {
  List<int> _timeData = [];
  List<int> get timeData => _timeData;

  void addTime(int time) {
    _timeData.add(time);
    notifyListeners();
  }

  void clearTimeData() {
    _timeData = [];
    notifyListeners();
  }

  int getTotalTime() {
    return _timeData.fold(0, (sum, item) => sum + item);
  }

  int getAverageTime() {
    return _timeData.isEmpty
        ? 0
        : (_timeData.reduce((a, b) => a + b) / _timeData.length).round();
  }

  int getLongestResponseTime() {
    return _timeData.isEmpty ? 0 : _timeData.reduce((a, b) => a > b ? a : b);
  }

  int getShortestResponseTime() {
    return _timeData.isEmpty ? 0 : _timeData.reduce((a, b) => a < b ? a : b);
  }
}
