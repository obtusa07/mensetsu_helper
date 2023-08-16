import 'package:flutter/material.dart';

class MensetsuPage extends StatefulWidget {
  const MensetsuPage({super.key});

  @override
  State<MensetsuPage> createState() => _MensetsuPageState();
}

class _MensetsuPageState extends State<MensetsuPage> {
  final List<String> _textList = ['자기소개를 해주세요', '마지막으로 질문 있나요?'];
  int _currentIndex = 0;
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
                    color: Colors.green,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            print('아이콘 터치');
                          },
                          icon: Icon(Icons.speaker),
                        ),
                        Text(
                          _textList[_currentIndex],
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 24,
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
                  print('버튼 클릭됨');
                  _currentIndex++;
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
