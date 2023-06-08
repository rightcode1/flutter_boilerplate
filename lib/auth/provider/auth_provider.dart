import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ppl_app/user/model/res/user_res.dart';
import 'package:ppl_app/user/provider/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Authorization 을 처리하기 위한 최상위 역할을 하는 Provider
final authProvider = ChangeNotifierProvider<AuthChangeNotifier>((ref) => AuthChangeNotifier(ref: ref));

class AuthChangeNotifier extends ChangeNotifier {
  final Ref ref;
  /// [routerProvider] 는 [authProvider] 를 listening 하고 있다가, notify 가 일어날 경우,
  /// [redirectLogic] 을 동작시킨다.
  AuthChangeNotifier({ required this.ref }) {
    // 유저의 상태가 변경될 경우(null 또는 다른 상태로 변경될 경우), notify 한다.
    ref.listen<UserResBase?>(userInfoProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  Future<String?> redirectLogic(BuildContext context, GoRouterState state) async {
    debugPrint(state.location);

    final UserResBase? user = ref.read(userInfoProvider);

    // 로그인 및 회원가입에 대하여 리다이렉트를 방지할 라우팅 플래그 변수 정의
    // final isLogin = state.location == '/login';
    // final isJoin = state.location.startsWith('/join');
    final isSplash = state.location == '/splash';

    /// FIXME: 시작: 스플래시 to 로그인 페이지로 이동을 위한 임시 로직, 반드시 제거 후 사용할 것.
    if (isSplash) {
      return '/login';
    }
    /// FIXME: 끝: 여기까지 제거할 것.

    // 유저 정보가 없는 상태는 null 인데, 만일 유저 정보가 없는 상태에서 다른 페이지를 열람 중이라면 로그인 페이지로 이동시킨다.
    // if (user == null) {
    //   return isLogin || isJoin ? null : '/login';
    // }

    /////////////////////////////////////////////
    // 하기는 유저의 상태가 null 이 아닐 경우에만 적용된다.
    /////////////////////////////////////////////

    // if (user is UserRes) {
    //   return isLogin || isJoin || isSplash ? '/' : null;
    // }
    //
    // if (user is UserResError) {
    //   return isLogin || isJoin ? '/login' : null;
    // }
    //
    return null;
  }
}