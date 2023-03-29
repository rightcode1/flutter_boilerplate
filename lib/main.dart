import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/common/config/scroll_behavior_without_glow.dart';
import 'package:flutter_boilerplate/common/provider/go_router_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(
    /// RivderPod 스코프 활성화
    const ProviderScope(
      child: _FlutterBoilerplate(),
    ),
  );
}

/// TODO: 앱의 엔트리 포인트를 지정한다. 이때, 엔트리포인트 클래스의 이름은 프로젝트 명으로 정한다.
class _FlutterBoilerplate extends ConsumerStatefulWidget {
  const _FlutterBoilerplate({Key? key}) : super(key: key);

  @override
  ConsumerState<_FlutterBoilerplate> createState() => _FlutterBoilerplateState();
}

class _FlutterBoilerplateState extends ConsumerState<_FlutterBoilerplate> {
  /// 초기 앱 환경을 세팅한다.
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    // 기기 Portrait, Landscape 세팅 로직, 기본 값으로 portrait 로 지정된다.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // 데이터 포맷팅 활성화 (DateTime to String 으로 원하는 형태로 포맷팅 할 수 있다.)
    initializeDateFormatting();

    // ScreenUtils 활성화
    return ScreenUtilInit(
      // 기준이 될 초기 디바이스 크기를 세팅한다.
      designSize: const Size(375, 667),
      minTextAdapt: true,
      // MaterialApp.router 를 통해 GoRouter 를 적용한다.
      builder: (_, child) => MaterialApp.router(
        builder: (context, child) {
          // AOS 환경에서 ScrollView 에 대한 상단 파란색 Glow 를 해제한다. 필요 없을 경우 해제하고, child 를 return 하면 된다.
          return ScrollConfiguration(
            behavior: ScrollBehaviorWithoutGlow(),
            child: child!,
          );
        },
        // 라우트 콘피그 (go_router_provider.dart) 적용, 전체 앱은 GoRouter 의 영향을 받는다.
        routerConfig: router,
        // 기본 폰트 지정
        theme: ThemeData(
          fontFamily: 'NotoSansKR',
        ),
      ),
    );
  }
}
