import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppl_app/auth/enum/auth_enum.dart';
import 'package:ppl_app/auth/provider/form/join/auth_join_form_provider.dart';
import 'package:ppl_app/common/component/buttons/common_button.dart';
import 'package:ppl_app/common/component/text_fields/custom_form_builder_text_field.dart';
import 'package:ppl_app/common/constant/color.dart';
import 'package:ppl_app/common/util/DataUtils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

/// 기본적인 형태의 회원가입 폼, 상황에 따라 적절히 변형하여 사용한다.
class AuthJoinFormColumn extends ConsumerStatefulWidget {
  const AuthJoinFormColumn({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthJoinFormColumn> createState() => _UserSignUpInfoFormState();
}

class _UserSignUpInfoFormState extends ConsumerState<AuthJoinFormColumn> {
  @override
  void dispose() {
    ref.invalidate(authJoinFormProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 현재 회원가입 폼을 관리하기 위한 Provider
    final formState = ref.watch(authJoinFormProvider);

    // 휴대폰 번호 인증 시, 서버로부터 예외가 발생하였을 경우 반환되는 팝업
    if (formState.verificationNumberStatus == AuthVerificationNumberStatus.failed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        DataUtils.showOneButtonDialog(
          context: context,
          title: '휴대폰 번호',
          content: '이미 등록한 휴대폰 번호이거나\n잘못된 번호 입니다.',
          buttonText: '확인',
          onButtonPressed: () {
            ref.read(authJoinFormProvider.notifier).changeVerificationNumberStatus(AuthVerificationNumberStatus.none);
            context.pop();
          },
        );
      });
    }

    return Column(
      children: [
        CustomFormBuilderTextField(
          name: 'loginId',
          label: '아이디',
          hintText: '영문, 숫자 조합 사용.',
          maxLength: 15,
          showCounterText: false,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.deny(' ', replacementString: ''),
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: '아이디를 입력해주세요.'),
            FormBuilderValidators.match(r'^[a-z]+[a-z0-9]{5,15}$', errorText: '영어+숫자 조합 또는 영어, 6자리 이상'),
          ]),
          // Debouncer 를 통해 동작한다.
          onChanged: (nickname) async {
            final pNickname = formState.formData['loginId'];
            await ref.read(authJoinFormProvider.notifier).checkAvailableLoginId(pNickname, nickname!);
          },
          helperText: formState.isLoginIdVerified == AuthVerificationStatus.verified ? '사용할 수 있는 아이디입니다.' : null,
          errorText: formState.isLoginIdVerified == AuthVerificationStatus.unverified ? '이미 존재하는 아이디입니다.' : null,
        ),
        SizedBox(
          height: 22.0.h,
        ),
        CustomFormBuilderTextField(
          name: 'password',
          label: '비밀번호',
          obscureText: true,
          hintText: '8-16자리 영문 대소문자, 숫자, 특수문자 중 3가지 이상',
          hintStyle: TextStyle(
            color: HINT_TEXT_COLOR,
            fontSize: 11.0.sp,
          ),
          helperText: formState.isPasswordVerified == AuthVerificationStatus.verified ? '사용할 수 있는 비밀번호입니다.' : null,
          maxLength: 16,
          showCounterText: false,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.deny(' ', replacementString: ''),
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: '비밀번호를 입력해주세요.'),
            FormBuilderValidators.match(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$", errorText: '최소 8자리 이상 문자, 숫자, 특수문자 포함'),
          ]),
          onChanged: (value) {
            if (value != null) {
              final pPassword = formState.formData['password'];
              ref.read(authJoinFormProvider.notifier).checkAvailablePassword(pPassword, value);
            }
          },
        ),
        CustomFormBuilderTextField(
          name: 'passwordConfirm',
          hintText: '비밀번호 확인',
          obscureText: true,
          maxLength: 16,
          showCounterText: false,
          keyboardType: TextInputType.text,
          helperText: formState.isPasswordConfirmVerified == AuthVerificationStatus.verified ? '비밀번호가 일치합니다.' : null,
          errorText: formState.isPasswordConfirmVerified == AuthVerificationStatus.unverified ||
                      formState.isPasswordConfirmVerified == AuthVerificationStatus.none
                  ? '비밀번호가 일치하지 않습니다.'
                  : null,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.deny(' ', replacementString: ''),
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: '비밀번호 확인란을 입력해주세요.'),
          ]),
          onChanged: (value) {
            if (value != null) {
              ref.read(authJoinFormProvider.notifier).checkPasswordConfirmEqualToPassword(value);
            }
          },
        ),
        SizedBox(
          height: 22.0.h,
        ),
        CustomFormBuilderTextField(
          name: 'name',
          label: '학부모 성함',
          hintText: '실명 기입',
          maxLength: 15,
          showCounterText: false,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9ㄱ-힣]'), replacementString: ''),
          ],
          validator: FormBuilderValidators.required(errorText: '성함을 입력해주세요.'),
        ),
        SizedBox(
          height: 22.0.h,
        ),
        CustomFormBuilderTextField(
          name: 'tel',
          label: '휴대폰 번호',
          hintText: '- 없이 입력',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.deny(' ', replacementString: ''),
          ],
          validator: FormBuilderValidators.required(errorText: '휴대폰 번호를 입력해주세요.'),
          enabled: formState.verificationNumberStatus == AuthVerificationNumberStatus.none,
        ),
        SizedBox(height: 10.0.h),
        SizedBox(
          width: double.infinity,
          // child: ElevatedButton(onPressed: () {}, child: Text('인증 번호 받기')),
          child: SizedBox(
            height: 40.0.h,
            child: CommonButton(
              buttonColor: PRIMARY_COLOR,
              text: formState.verificationNumberStatus == AuthVerificationNumberStatus.none ? '인증 번호 받기' : '인증 번호 전송 완료!',
              // FIXME: 휴대폰 정규식 도입 고려
              // 인증번호 받기가 전송된 상태가 아닐 경우, 전화번호가 10자 이상인 경우 버튼을 활성화시킨다.
              isActive: formState.verificationNumberStatus == AuthVerificationNumberStatus.none && formState.formData['tel'].toString().length >= 10,
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                ref.read(authJoinFormProvider.notifier).sendVerificationNumber();
              },
              // height: 40.0.h,
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 22.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 안에서 TextFormField 는 Width 가 얼마나 될지 Flutter 가 판단할 수 없다. 따라서 Expanded 를 적용한다.
            Expanded(
              child: CustomFormBuilderTextField(
                name: 'verificationNumber',
                label: '인증 번호',
                hintText: '인증번호 입력',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // 인증번호가 전송된 상태에서만 Input 을 활성화시킨다.
                enabled: formState.verificationNumberStatus != AuthVerificationNumberStatus.none &&
                    formState.verificationNumberStatus != AuthVerificationNumberStatus.confirmed,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: '인증번호를 입력해주세요.'),
                ]),
                helperText: formState.verificationNumberStatus == AuthVerificationNumberStatus.confirmed ? '인증이 완료되었습니다.' : null,
                errorText: formState.verificationNumberStatus == AuthVerificationNumberStatus.invalid ? '인증번호가 올바르지 않습니다.' : null,
              ),
            ),
            SizedBox(
              width: 10.0.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0.h),
              child: SizedBox(
                width: 84.0.w,
                height: 53.0.h,
                child: CommonButton(
                  buttonColor: PRIMARY_COLOR,
                  text: '확인',
                  // 인증번호 전송 상태가 초기 상태가 아니고, 인증에 성공한 상황이 아닐 경우에만 인증완료 버튼을 활성화시킨다.
                  isActive: formState.verificationNumberStatus != AuthVerificationNumberStatus.none &&
                      formState.verificationNumberStatus != AuthVerificationNumberStatus.confirmed,
                  onPressed: () async {
                    final confirmed = await ref.read(authJoinFormProvider.notifier).checkVerificationNumber();
                    if (confirmed) {
                    } else {}
                  },
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
