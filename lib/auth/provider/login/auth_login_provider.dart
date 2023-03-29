import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/auth/model/req/login/auth_req_login.dart';
import 'package:flutter_boilerplate/auth/provider/form/login/auth_login_form_provider.dart';
import 'package:flutter_boilerplate/auth/repository/auth_repository.dart';
import 'package:flutter_boilerplate/common/constant/data.dart';
import 'package:flutter_boilerplate/common/provider/secure_storage_provider.dart';
import 'package:flutter_boilerplate/user/provider/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLoginProvider = StateNotifierProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthLoginStateNotifier(ref: ref, authRepository: authRepository);
});

class AuthLoginStateNotifier extends StateNotifier<AuthReqLogin> {
  final Ref ref;
  final AuthRepository authRepository;

  AuthLoginStateNotifier({
    required this.ref,
    required this.authRepository,
  }) : super(AuthReqLogin(loginId: '', password: ''));

  /// Form 데이터를 모델로 변환한다.
  void toModel() {
    final formState = ref.read(authLoginFormProvider);
    state = AuthReqLogin.fromJson(formState.formData);
  }

  /// 서버로 데이터를 전송시킨 후, 로그인한다.
  Future<bool> login() async {
    try {
      toModel();
      final response = await authRepository.login(body: state);

      if (response.statusCode == HttpStatus.ok) {
        debugPrint('로그인에 성공하였습니다. message=${response.message}');
        await ref.read(secureStorageProvider).write(key: ACCESS_TOKEN_KEY, value: response.token);
        await ref.read(userInfoProvider.notifier).getInfo();
        return true;
      } else {
        throw Exception('정의되지 않은 상태코드입니다. statusCode=${response.statusCode}');
      }
    } catch (err, stack) {
      if (err is DioError && err.response?.statusCode == HttpStatus.badRequest) {
        debugPrint('로그인에 실패했습니다. message=${err.response?.data['message']}');
        return false;
      } else {
        debugPrint(err.toString());
        debugPrint(stack.toString());
        throw Exception('예상치 못한 오류가 발생했습니다. 로그를 확인해주세요.');
      }
    }
  }
}