import 'package:flutter/material.dart';
import 'package:mensetsu_helper/screens/home.dart';

class Result extends StatelessWidget {
  Result({Key? key, required this.timeData}) : super(key: key) {
    resultData = [
      timeData.fold(0, (previousValue, element) => previousValue + element),
      (timeData.reduce((value, element) => value + element) / timeData.length)
          .round(),
      timeData.reduce((value, element) => value > element ? value : element),
      timeData.reduce((value, element) => value < element ? value : element)
    ];
  }

  final List<int> timeData;
  final List<String> titles = [
    "Total Mensetsu Time",
    "Average Response Time",
    "Longest Response Time",
    "Shortest Response Time"
  ];
  late final List<int> resultData;

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minuteString = minutes > 0 ? '$minutes' : '';
    String secondString = '$remainingSeconds';

    if (minutes > 0 && remainingSeconds < 10) {
      secondString = '0$remainingSeconds';
    }

    return minutes > 0 ? '$minuteString m $secondString s' : '$secondString s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'RESULT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Image.asset('assets/images/mensetsu_result.png',
                    height: MediaQuery.of(context).size.height * 0.24),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Text(
                                  titles[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatTime(resultData[index]),
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()),
                    ModalRoute.withName('/'),
                  );
                },
                child: Text(
                  'もう一度',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
