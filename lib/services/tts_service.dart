import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_tts/flutter_tts.dart";

class TtsService extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text) async {
    await _tts.setLanguage("ja");
    if (Platform.isAndroid) {
      await _tts.setVoice({"name": "ja-jp-x-jab-network", "locale": "ja-JP"});
    }

    await _tts.setVolume(1.0);
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1);
    await _tts.speak(text);
    notifyListeners();
  }

  void stopTts() {
    _tts.stop();
    notifyListeners();
  }
}
