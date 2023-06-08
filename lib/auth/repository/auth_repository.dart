import 'package:dio/dio.dart';
import 'package:ppl_app/auth/enum/auth_enum.dart';
import 'package:ppl_app/auth/model/req/join/auth_req_join.dart';
import 'package:ppl_app/auth/model/req/login/auth_req_login.dart';
import 'package:ppl_app/common/constant/data.dart';
import 'package:ppl_app/common/model/base_res.dart';
import 'package:ppl_app/common/provider/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final String baseUrl = '$baseHostV1/auth';

  return AuthRepository(dio, baseUrl: baseUrl);
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  /// 회원가입
  @POST('/join')
  Future<BaseResponse> join({
    @Body() required AuthReqJoin body,
  });

  @POST('/login')
  Future<BaseResponse> login({
    @Body() required AuthReqLogin body,
  });

  /// 아이디 중복 체크
  @GET('/existLoginId')
  Future<BaseResponse> existLoginId({
    @Query('loginId') required String loginId,
  });

  /// 핸드폰 인증 번호 발송
  @GET('/certificationNumberSMS')
  Future<BaseResponse> certificationNumberSMS({
    /// 핸드폰 번호
    @Query('tel') required String tel,

    /// 구분 ("join", "find", "update")
    @Query('diff') required AuthDiff diff,
  });

  /// 인증하기
  @GET('/confirm')
  Future<BaseResponse> confirm({
    /// 핸드폰 번호
    @Query('tel') required String tel,

    /// 인증번호
    @Query('confirm') required String confirm,
  });

  /// 비밀번호 변경
// @POST('/passwordChange')
// Future<BaseResponse> passwordChange({
//   @Body() required AuthReqPasswordChange body,
// });
}
