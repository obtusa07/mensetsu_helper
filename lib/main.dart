import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mensetsu_helper/models/text_list_model.dart';
import 'package:mensetsu_helper/screens/home.dart';
import 'package:mensetsu_helper/services/mensetsu_time_service.dart';
import 'package:mensetsu_helper/services/timer_service.dart';
import 'package:mensetsu_helper/services/tts_service.dart';
import 'package:mensetsu_helper/utils/logger.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'viewModels/result_grid_viewmodel.dart';

StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object> snapshot) {
  if (snapshot.hasError) {
    logger.d('error occur while loading ~');
    return const Text('Error Occur');
  } else if (snapshot.hasData) {
    logger.d('data is ${snapshot.data.toString()}');
    return const MyApp();
  } else {
    return const SplashScreen();
  }
}

void main() async {
  // 적절한 Ad 설정을 하지 않고 아래 코드를 실행할 경우 정상 작동 불가
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MensetsuTimeService()),
        ChangeNotifierProvider(create: (context) => TextListModel()),
        ChangeNotifierProvider(create: (context) => TtsService()),
        ChangeNotifierProvider(create: (context) => TimerService()),
        ChangeNotifierProvider(create: (context) => ResultGridViewModel()),
      ],
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
