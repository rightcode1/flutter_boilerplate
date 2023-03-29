import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/constant/data.dart';
import 'package:flutter_boilerplate/common/provider/secure_storage_provider.dart';
import 'package:flutter_boilerplate/user/model/res/user_res.dart';
import 'package:flutter_boilerplate/user/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 유저 정보를 관리하는 Provider. authProvider 가 listening 한다.
final userInfoProvider = StateNotifierProvider<UserInfoStateNotifier, UserResBase?>(
  name: 'userInfoProvider',
      (ref) {
    final userRepository = ref.watch(userRepositoryProvider);

    return UserInfoStateNotifier(ref: ref, userRepository: userRepository);
  },
);

class UserInfoStateNotifier extends StateNotifier<UserResBase?> {
  final UserRepository userRepository;
  final Ref ref;

  UserInfoStateNotifier({
    required this.userRepository,
    required this.ref,
  }) : super(UserResLoading()) {
    getInfo();
  }

  /////////////////////////////////////////////////////////////////////////////////
  // 비즈니스 로직
  /////////////////////////////////////////////////////////////////////////////////

  /// 서버로부터 유저 정보를 가져온다.
  Future<void> getInfo() async {
    final token = await ref.read(secureStorageProvider).read(key: ACCESS_TOKEN_KEY);

    if (token == null) {
      state = null;
      return;
    }

    try {
      final response = await userRepository.info();
      state = response.data;
    } catch (err, stack) {
      debugPrint(err.toString());
      debugPrint(stack.toString());
      state = null;
      await ref.read(secureStorageProvider).delete(key: ACCESS_TOKEN_KEY);
      throw Exception('유저 정보를 가져오는 중 오류가 발생했습니다. 기존 토큰을 제거합니다.');
    }
  }
}
