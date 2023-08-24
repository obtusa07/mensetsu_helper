import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mensetsu_helper/screens/mensetsu_time_service.dart';
import 'package:mensetsu_helper/screens/result.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mensetsu_helper/screens/banner_ad_widget.dart';
import 'package:provider/provider.dart';

class MensetsuPage extends StatefulWidget {
  const MensetsuPage({super.key});

  @override
  State<MensetsuPage> createState() => _MensetsuPageState();
}

class _MensetsuPageState extends State<MensetsuPage> {
  final List<String> _textList = [
    '自己紹介をしてください',
    '学生時代に頑張ったことを教えてください',
    '誰にも負けないことは何ですか',
    '短所を教えてください',
    'あなたの失敗体験を教えてください',
    '志望動機を教えてください',
    '就活の軸を教えてください',
    '入社後にしたいことを教えてください',
    '最後に質問はありますか？'
  ];
  int _currentIndex = 0;
  int _currentSecond = 0;
  List<int> _timeData = [];
  final FlutterTts tts = FlutterTts();
  Timer? _timer;

  Future<void> _speak(String text) async {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

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
        setState(() {
          _currentSecond++;
        });
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
    return ChangeNotifierProvider(
      create: (_) => MensetsuTimeService(),
      child: Scaffold(
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("今回の面接は失敗しました..\nもう一回やりましょう"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('違う'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                                _timer?.cancel();
                                _currentIndex = 0;
                                _currentSecond = 0;
                                _timeData = [];
                              },
                              child: Text('そうだ'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'オワタ...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
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
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Image.asset('assets/images/interviewer_man.png'),
                    SizedBox(height: 10),
                    LinearPercentIndicator(
                      animation: true,
                      percent: (120 - _currentSecond >= 0)
                          ? (120 - _currentSecond) / 120
                          : 0,
                      lineHeight: 25,
                      animationDuration: 0,
                      progressColor:
                          (_currentSecond >= 90) ? Colors.orange : Colors.green,
                      barRadius: const Radius.circular(16),
                      center: Text(
                        (120 - _currentSecond >= 0)
                            ? "${120 - _currentSecond} s"
                            : "0s",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                    tts.stop();
                    setState(() {
                      _timeData.add(_currentSecond);
                      _currentSecond = 0;
                      if (_currentIndex == _textList.length - 1) {
                        _timer?.cancel();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Result(timeData: _timeData),
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
                  child: Text(
                    _currentIndex < _textList.length - 1 ? '次へ' : '完了',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                height: 75,
                child: BannerAdWidget(), // 광고 배너를 추가합니다.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
