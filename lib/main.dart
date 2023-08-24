import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mensetsu_helper/screens/home.dart';
import 'package:mensetsu_helper/screens/mensetsu_time_service.dart';
import 'package:provider/provider.dart';

void main() async {
  // 적절한 Ad 설정을 하지 않고 아래 코드를 실행할 경우 정상 작동 불가
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => MensetsuTimeService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
