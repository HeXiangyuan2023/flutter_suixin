import 'package:dio/dio.dart';

enum XTErrorType {
  // 未授权
  unauthorized,
  other,
}

class XTBizError implements Exception {
  final RequestOptions requestOptions;

  final response;

  final String code;

  final XTErrorType type;

  final String message;

  final List<dynamic> ma;

  final String mc;

  XTBizError(
      {required this.requestOptions,
      required this.mc,
      this.response,
      required this.code,
      required this.type,
      required this.message,
      required this.ma});

  factory XTBizError.unauthorized({
    required RequestOptions requestOptions,
    required String code,
    required String reason,
  }) =>
      XTBizError(
          type: XTErrorType.unauthorized,
          message: reason,
          code: code,
          requestOptions: requestOptions,
          response: null,
          ma: List.empty(),
          mc: "");

  factory XTBizError.other(
          {required RequestOptions requestOptions,
          required String code,
          required String reason}) =>
      XTBizError(
          type: XTErrorType.other,
          code: code,
          message: reason,
          requestOptions: requestOptions,
          response: null,
          ma: [],
          mc: "");
}
