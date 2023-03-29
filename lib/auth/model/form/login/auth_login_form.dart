/// 로그인을 위한 API 를 서버로 요청하기 위해 사용되는 Form Model
class AuthLoginForm {
  final Map<String, dynamic> formData;

  /// 아이디가 비어있는지 여부
  final bool isLoginIdEmpty;

  /// 비밀번호가 비어있는지 여부
  final bool isPasswordEmpty;

  const AuthLoginForm({
    this.formData = const {},
    this.isLoginIdEmpty = false,
    this.isPasswordEmpty = false,
  });

  AuthLoginForm copyWith({
    Map<String, dynamic>? formData,
    bool? isLoginIdEmpty,
    bool? isPasswordEmpty,
  }) {
    return AuthLoginForm(
      formData: formData ?? this.formData,
      isLoginIdEmpty: isLoginIdEmpty ?? this.isLoginIdEmpty,
      isPasswordEmpty: isPasswordEmpty ?? this.isPasswordEmpty,
    );
  }
}
