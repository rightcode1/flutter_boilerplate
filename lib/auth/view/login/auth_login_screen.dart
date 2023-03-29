import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/auth/component/login/column/auth_login_button_column.dart';
import 'package:flutter_boilerplate/auth/component/login/form/auth_login_form_column.dart';
import 'package:flutter_boilerplate/auth/component/login/row/auth_login_find_row.dart';
import 'package:flutter_boilerplate/auth/provider/form/login/auth_login_form_provider.dart';
import 'package:flutter_boilerplate/common/constant/form_keys.dart';
import 'package:flutter_boilerplate/common/layout/default_layout.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 기본 형태의 로그인 스크린, 형태에 맞게 재정의하여 사용한다.
class AuthLoginScreen extends ConsumerWidget {
  static get routeName => 'AuthLoginScreen';

  const AuthLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        child: FormBuilder(
      key: loginFormKey,
      onChanged: () {
        loginFormKey.currentState!.save();
        ref.read(authLoginFormProvider.notifier).saveForm(loginFormKey.currentState!.value);
      },
      child: Column(
        children: [
          SizedBox(
            height: 20.0.h,
          ),
          SizedBox(
            height: 23.0.h,
          ),
          Expanded(
            child: Column(
              children: [
                // 로그인 폼
                const AuthLoginFormColumn(),
                SizedBox(
                  height: 15.5.h,
                ),
                // 회원가입 및 로그인 버튼
                const AuthLoginButtonColumn(),
              ],
            ),
          ),
          // 아이디 찾기 및 비밀번호 찾기 텍스트 버튼
          const AuthLoginFindRow(),
        ],
      ),
    ));
  }
}
