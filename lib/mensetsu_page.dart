import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mensetsu_helper/result.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MensetsuPage extends StatefulWidget {
  const MensetsuPage({super.key});

  @override
  State<MensetsuPage> createState() => _MensetsuPageState();
}

class _MensetsuPageState extends State<MensetsuPage> {
  final List<String> _textList = ['自己紹介をしてください', '就活の軸を教えてください'];
  int _currentIndex = 0;
  int _currentSecond = 0;
  List<int> _TimeData = [];
  final FlutterTts tts = FlutterTts();
  Timer? _timer;

  Future<void> _speak(String text) async {
    await tts.setLanguage("ja");
    if (Platform.isAndroid) {
      await tts.setVoice({"name": "ja-jp-x-jab-network", "locale": "ja-JP"});
    }
    await tts.setVolume(1.0);
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1);
    await tts.speak(text);

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _currentSecond++;
        print(120 - _currentSecond);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _speak(_textList[_currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 2,
              right: 24,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {},
                child: Text('オワタ...'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            print('아이콘 터치');
                            _speak(_textList[
                                _currentIndex]); // 아이콘 버튼을 누르면 TTS 재생됩니다.
                          },
                          icon: Icon(Icons.volume_up),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _textList[_currentIndex],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Image.asset('assets/images/interviewer_man.png'),
                ],
              ),
            ),
            Positioned(
              bottom: 100,
              left: 24,
              right: 24,
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  setState(() {
                    _TimeData.add(_currentSecond);
                    _currentSecond = 0;
                    if (_currentIndex == _textList.length - 1) {
                      print(_TimeData);
                      _timer?.cancel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Result(),
                        ),
                      );
                    }
                    if (_currentIndex < _textList.length - 1) {
                      _timer?.cancel();
                      _currentIndex++;
                      _speak(_textList[_currentIndex]);
                    }
                  });
                },
                child: Text(_currentIndex < _textList.length - 1 ? '次へ' : '完了'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
