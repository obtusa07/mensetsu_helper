import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late final BannerAd banner;

  @override
  void initState() {
    super.initState();

    //광고 ID 설정
    final adUnitId = Platform.isIOS
        // 테스트용 배너 ID ca-app-pub-3940256099942544/6300978111
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/6300978111';

    // 광고 생성
    banner = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      // 광고의 생명주기가 변경될 때마다 실행할 함수 설정
      listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
      // 광고 요청 정보를 담고 있는 클래스
      request: AdRequest(),
    );
    // 광고 로딩
    banner.load();
  }

  @override
  void dispose() {
    // 위젯이 dispose 되면 광고도 dispose
    banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: AdWidget(ad: banner),
    );
  }
}
