import 'package:flutter_boilerplate/auth/provider/auth_provider.dart';
import 'package:flutter_boilerplate/auth/view/join/auth_join_screen.dart';
import 'package:flutter_boilerplate/auth/view/login/auth_login_screen.dart';
import 'package:flutter_boilerplate/common/view/splash_screen.dart';
import 'package:flutter_boilerplate/example/view/example_screen.dart';
import 'package:flutter_boilerplate/home/view/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// GoRouter 에 대한 콘피그를 설정한다. 엔트리포인트(main.dart) 에서 활용한다.
final routerProvider = Provider<GoRouter>(
  (ref) {
    // FIXME: 라우트 항목 따로 분리하기
    final List<GoRoute> routes = [
      // 예제 스크린 (Playground)
      GoRoute(
        path: '/example',
        name: ExampleScreen.routeName,
        builder: (context, state) => const ExampleScreen(),
      ),
      // 스플래시
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      // // 홈
      GoRoute(
        path: '/',
        name: HomeScreen.routeName,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      // 로그인 페이지
      GoRoute(
        path: '/login',
        name: AuthLoginScreen.routeName,
        builder: (context, state) => const AuthLoginScreen(),
      ),
      // 회원 가입
      GoRoute(
        path: '/join',
        name: AuthJoinScreen.routeName,
        builder: (context, state) {
          return const AuthJoinScreen();
        },
      ),
    ];

    final provider = ref.read(authProvider);

    // authProvider 를 구독하고 있다가, userInfo 의 상태가 변경되면 redirectLoic 을 호출시킨다.
    return GoRouter(
      routes: routes,
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirectLogic,
    );
  },
);
