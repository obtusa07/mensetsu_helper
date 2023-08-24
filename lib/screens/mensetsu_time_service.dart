import 'package:flutter/material.dart';

class MensetsuTimeService extends ChangeNotifier {
  List<int> _timeData = [];
  List<int> get timeData => _timeData;

  void addTime(int time) {
    _timeData.add(time);
    notifyListeners();
  }
}
