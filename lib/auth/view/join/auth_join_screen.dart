import 'package:flutter/material.dart';
import 'package:ppl_app/auth/component/join/form/auth_join_form_column.dart';
import 'package:ppl_app/auth/provider/form/join/auth_join_form_provider.dart';
import 'package:ppl_app/auth/provider/join/auth_join_provider.dart';
import 'package:ppl_app/common/component/buttons/common_button.dart';
import 'package:ppl_app/common/constant/form_keys.dart';
import 'package:ppl_app/common/layout/default_layout.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// 기본 형태의 회원가입 스크린, 형태에 맞게 재정의하여 사용한다.
class AuthJoinScreen extends ConsumerStatefulWidget {
  static get routeName => 'AuthJoinScreen';

  const AuthJoinScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AuthJoinScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends ConsumerState<AuthJoinScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      showAppBar: true,
      showBack: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30.0.h,
              ),
              // 회원가입 폼
              FormBuilder(
                key: joinFormKey,
                onChanged: () {
                  // 현재 폼의 상태가 변경될 때마다 폼 Provider 에 현재 Form 의 값을 저장한다.
                  joinFormKey.currentState!.save();
                  ref.read(authJoinFormProvider.notifier).saveForm(joinFormKey.currentState!.value);
                },
                child: const AuthJoinFormColumn(),
              ),
              SizedBox(height: 40.0.h,),
              // Consumer 를 통해 authJoinFormProvider 의 상태가 변경될 때 버튼만 리빌드 될 수 있도록 한다.
              SizedBox(
                height: 51.5.h,
                child: Consumer(
                  builder: (context, ref, child) {
                    final formState = ref.watch(authJoinFormProvider);

                    return CommonButton(
                      text: '회원가입',
                      isActive: formState.isAllValidated,
                      onPressed: () async {
                        // 현재 Form 데이터를 Model 로 변환 후, 서버로 전송한다..
                        await ref.read(authJoinProvider.notifier).join();
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
