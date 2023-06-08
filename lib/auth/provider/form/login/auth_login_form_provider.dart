import 'package:ppl_app/auth/model/form/login/auth_login_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLoginFormProvider = StateNotifierProvider<AuthLoginFormStateNotifier, AuthLoginForm>((ref) {
  return AuthLoginFormStateNotifier();
});

class AuthLoginFormStateNotifier extends StateNotifier<AuthLoginForm> {
  AuthLoginFormStateNotifier() : super(const AuthLoginForm());

  /// 폼 데이터를 저장한다.
  void saveForm(Map<String, dynamic> formData) {
    state = state.copyWith(
      formData: formData,
    );
  }

  /// [isLoginIdEmpty] 를 true 로 변경한다.
  void changeLoginIdIsEmpty() {
    state = state.copyWith(isLoginIdEmpty: true);
  }

  /// [isLoginIdEmpty] 를 false 로 변경한다.
  void changeLoginIdIsNotEmpty() {
    state = state.copyWith(isLoginIdEmpty: false);
  }

  /// [isPasswordEmpty] 를 true 로 변경한다.
  void changePasswordIsEmpty() {
    state = state.copyWith(isPasswordEmpty: true);
  }

  /// [isPasswordEmpty] 를 false 로 변경한다.
  void changePasswordIsNotEmpty() {
    state = state.copyWith(isPasswordEmpty: false);
  }
}
