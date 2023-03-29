import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/auth/provider/form/login/auth_login_form_provider.dart';
import 'package:flutter_boilerplate/common/component/text_fields/custom_form_builder_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// 로그인 기본 폼, 형태에 맞게 재정의하여 사용한다.
class AuthLoginFormColumn extends ConsumerWidget {
  const AuthLoginFormColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(authLoginFormProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomFormBuilderTextField(
          name: 'loginId',
          label: '아이디',
          hintText: '아이디 입력',
          errorText: formState.isLoginIdEmpty ? '아이디를 입력해주세요.' : null,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.deny(' '),
          ],
          validator: FormBuilderValidators.required(errorText: '아이디를 입력해주세요.'),
          onChanged: (loginId) => loginId != null ? ref.read(authLoginFormProvider.notifier).changeLoginIdIsNotEmpty() : null,
        ),
        SizedBox(
          height: 16.5.h,
        ),
        CustomFormBuilderTextField(
          name: 'password',
          label: '비밀번호',
          hintText: '비밀번호 입력',
          errorText: formState.isPasswordEmpty ? '비밀번호를 입력해주세요.' : null,
          obscureText: true,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.deny(' '),
          ],
          validator: FormBuilderValidators.required(errorText: '비밀번호를 입력해주세요.'),
          onChanged: (password) => password != null ? ref.read(authLoginFormProvider.notifier).changePasswordIsNotEmpty() : null,
        ),
      ],
    );
  }
}
