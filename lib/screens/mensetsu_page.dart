import 'package:flutter/material.dart';

import 'package:mensetsu_helper/models/text_list_model.dart';
import 'package:mensetsu_helper/services/mensetsu_time_service.dart';
import 'package:mensetsu_helper/screens/result.dart';
import 'package:mensetsu_helper/utils/logger.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mensetsu_helper/screens/banner_ad_widget.dart';
import 'package:provider/provider.dart';
import '../services/timer_service.dart';
import '../services/tts_service.dart';

class MensetsuPage extends StatefulWidget {
  const MensetsuPage({super.key});

  @override
  State<MensetsuPage> createState() => _MensetsuPageState();
}

class _MensetsuPageState extends State<MensetsuPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<TimerService>().startTimer();
    context
        .read<TtsService>()
        .speak(context.read<TextListModel>().textList[_currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final mensetsuTimeService =
        Provider.of<MensetsuTimeService>(context, listen: false);
    TextListModel textListModel = context.watch<TextListModel>();
    TtsService ttsService = context.watch<TtsService>();
    TimerService timerService = context.watch<TimerService>();

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
                            onPressed: () async {
                              logger.d('navigate to Home Page');
                              Navigator.pop(context);
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                              timerService.resetTimer();
                              _currentIndex = 0;
                              mensetsuTimeService.clearTimeData();
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
                            onPressed: () async {
                              logger.d('activate TTS button');
                              ttsService.speak(context
                                  .read<TextListModel>()
                                  .textList[_currentIndex]);
                            },
                            icon: Icon(Icons.volume_up),
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                context
                                    .read<TextListModel>()
                                    .textList[_currentIndex],
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
                    percent: (120 - timerService.currentSecond >= 0)
                        ? (120 - timerService.currentSecond) / 120
                        : 0,
                    lineHeight: 25,
                    animationDuration: 0,
                    progressColor: (timerService.currentSecond >= 90)
                        ? Colors.orange
                        : Colors.green,
                    barRadius: const Radius.circular(16),
                    center: Text(
                      (120 - timerService.currentSecond >= 0)
                          ? "${120 - timerService.currentSecond} s"
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
                onPressed: () async {
                  ttsService.stopTts();
                  mensetsuTimeService.addTime(timerService.currentSecond);
                  timerService.stopTimer();
                  if (_currentIndex == textListModel.textList.length - 1) {
                    logger.d('navigate to Result Page');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Result()),
                    );
                  }
                  if (_currentIndex < textListModel.textList.length - 1) {
                    logger.d('show next Question');
                    _currentIndex++;
                    ttsService.speak(textListModel.textList[_currentIndex]);
                    timerService.startTimer();
                  }
                },
                child: Text(
                  _currentIndex < textListModel.textList.length - 1
                      ? '次へ'
                      : '完了',
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
              child: BannerAdWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
