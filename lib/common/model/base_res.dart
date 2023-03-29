import 'package:json_annotation/json_annotation.dart';

part 'base_res.g.dart';

/// 서버의 기본 Response 형태, 서버에 따라 항목이 달라질 수 있으므로 유의한다.
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  final int statusCode;
  final String message;
  final String? token;
  final String? role;
  final T? data;

  BaseResponse({
    required this.statusCode,
    required this.message,
    this.token,
    this.role,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$BaseResponseFromJson(json, fromJsonT);

  @override
  String toString() {
    return 'BaseResponse{statusCode: $statusCode, message: $message, token: $token, role: $role, data: $data}';
  }
}
