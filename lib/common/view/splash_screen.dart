import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static get routeName => 'SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Container(
        // 스플래시 스크린에 대한 이미지가 필요할 경우, BoxDecoration 을 통해 지정한다.
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     image: AssetImage('asset/images/splash/splash_background_image@3x.png'),
        //   )
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Center(
              child: Text('스플래시 스크린'),
            )
          ],
        ),
      ),
    );
  }
}
