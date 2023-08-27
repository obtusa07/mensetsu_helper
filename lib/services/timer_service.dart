import "dart:async";
import "package:flutter/material.dart";

class TimerService with ChangeNotifier {
  Timer? _timer;
  int _currentSecond = 0;

  int get currentSecond => _currentSecond;

  void startTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _currentSecond++;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _currentSecond = 0;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _currentSecond = 0;
    notifyListeners();
  }

  void cancelTimer() {
    _timer?.cancel();
    notifyListeners();
  }
}
