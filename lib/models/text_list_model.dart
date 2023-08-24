import 'package:flutter/material.dart';

class TextListModel extends ChangeNotifier {
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

  List<String> get textList => _textList;
}
