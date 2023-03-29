import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/auth/provider/form/login/auth_login_form_provider.dart';
import 'package:flutter_boilerplate/auth/provider/login/auth_login_provider.dart';
import 'package:flutter_boilerplate/auth/view/join/auth_join_screen.dart';
import 'package:flutter_boilerplate/common/component/buttons/common_button.dart';
import 'package:flutter_boilerplate/common/constant/color.dart';
import 'package:flutter_boilerplate/common/util/DataUtils.dart';
import 'package:flutter_boilerplate/home/view/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// 로그인 / 회원가입 버튼 컬럼 컴포넌트, 형태에 맞게 적절히 변형하여 사용한다.
class AuthLoginButtonColumn extends ConsumerWidget {
  const AuthLoginButtonColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 51.5.h,
          child: CommonButton(
            text: '로그인',
            onPressed: () async {
              // FIXME: 홈 스크린으로 넘어가기 위한 임시 라우팅
              context.goNamed(HomeScreen.routeName);

              // 현재 로그인 데이터를 가져와 비어있을 경우 검증 상태를 변경한다.
              // final formData = ref.read(authLoginFormProvider).formData;
              //
              // final String loginId = formData['loginId']?? '';
              // final String password = formData['password'] ?? '';
              //
              // if (loginId.isEmpty || password.isEmpty) {
              //   loginId.isEmpty ? ref.read(authLoginFormProvider.notifier).changeLoginIdIsEmpty() : null;
              //   password.isEmpty ? ref.read(authLoginFormProvider.notifier).changePasswordIsEmpty() : null;
              //   return;
              // }
              //
              // final result = await ref.read(authLoginProvider.notifier).login();

              // 로그인에 실패했을 경우 (아이디 혹은 비밀번호 불일치)
              // if (!result && context.mounted) {
              //   DataUtils.showOneButtonDialog(
              //     context: context,
              //     title: '로그인 실패!',
              //     content: '아이디 혹은 비밀번호가\n올바르지 않습니다.',
              //     buttonText: '확인',
              //     onButtonPressed: () {
              //       context.pop();
              //     },
              //   );
              // }
            },
            buttonColor: PRIMARY_COLOR,
            fontSize: 15.0.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 8.5.h,
        ),
        SizedBox(
          height: 51.5.h,
          child: CommonButton(
            text: '회원가입',
            onPressed: () {
              context.pushNamed(AuthJoinScreen.routeName);
            },
            buttonColor: SIGN_UP_BUTTON_BG_COLOR,
            fontSize: 15.0.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
