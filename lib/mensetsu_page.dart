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
        child: Column(
          children: [
            Text(_textList[_currentIndex]),
            ElevatedButton(
              onPressed: () {
                print('버튼 클릭됨');
              },
              child: Text(_currentIndex < _textList.length - 1 ? '다음' : '종료'),
            ),
          ],
        ),
      ),
    );
  }
}
