import 'dart:io';

import 'package:dio/dio.dart';
import 'package:suixin_app/api/biz_error.dart';
import 'package:suixin_app/api/curl_dio_logger.dart';
import 'package:suixin_app/common/cookie_manager.dart';
import 'package:suixin_app/common/toast.dart';
import 'package:suixin_app/logger.dart';

/// 接口是否拦截这次报错
/// 用作接口报错的时候针对某个特殊业务进行处理
/// true 表示拦截这次并且处理报错 不在通用处理错误
typedef ApiErrorHandler = bool Function(XTBizError error);

class Request {
  late Dio _dio;
  var headers = <String, String>{};
  var baseHost = "xt.com";
  var apiEvn = "pro";
  final baseUrl = "http://152.32.217.3:8088";

  static final Request _instance = Request._internal();

  factory Request() {
    return _instance;
  }

  String _getSchemata() {
    if (apiEvn == "dev" || apiEvn == "test") {
      return "http";
    }
    return "https";
  }

  bool _isProEnv() {
    if (apiEvn == "dev" || apiEvn == "test") {
      return false;
    }
    return true;
  }

  /// post 发送 api 接口请求
  Future post({
    required String path,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    topDomain = "app",
    Map<String, dynamic>? queryParameters,
    ApiErrorHandler? apiErrorHandler,
  }) async {
    final url = "$baseUrl$path";
    try {
      final response = await _dio.post(url,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken);
      final dataJSON = DioWrapper.responseWrapper(response);
      return dataJSON;
    } catch (e) {
      _resolveResponseError(url: url, e: e, apiErrorHandler: apiErrorHandler);
      rethrow;
    }
  }

  /// get 发送 api 接口请求
  Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    topDomain = "app",
    ApiErrorHandler? apiErrorHandler,
  }) async {
    final url = "$baseUrl$path";
    try {
      final response = await _dio.get(url,
          queryParameters: queryParameters, cancelToken: cancelToken);
      final dataJSON = DioWrapper.responseWrapper(response);
      return dataJSON;
    } catch (e) {
      _resolveResponseError(url: url, e: e, apiErrorHandler: apiErrorHandler);
      rethrow;
    }
  }

  /// put 发送 api 接口请求
  Future put({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    topDomain = "app",
    ApiErrorHandler? apiErrorHandler,
  }) async {
    final url = "$baseUrl$path";
    try {
      final response = await _dio.put(url,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken);
      final dataJSON = DioWrapper.responseWrapper(response);
      return dataJSON;
    } catch (e) {
      _resolveResponseError(url: url, e: e, apiErrorHandler: apiErrorHandler);
      rethrow;
    }
  }

  /// delete 发送 api 接口请求
  Future delete({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    topDomain = "app",
    ApiErrorHandler? apiErrorHandler,
  }) async {
    final url = "$baseUrl$path";
    try {
      final response = await _dio.delete(url,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken);
      final dataJSON = DioWrapper.responseWrapper(response);
      return dataJSON;
    } catch (e) {
      _resolveResponseError(url: url, e: e, apiErrorHandler: apiErrorHandler);
      rethrow;
    }
  }

  _resolveResponseError(
      {required String url,
      required Object e,
      ApiErrorHandler? apiErrorHandler}) {
    if (e is DioError) {
      DioWrapper.handlerDioError(e);
      return;
    }

    if (e is XTBizError) {
      if (apiErrorHandler == null) {
        return;
      }

      if (!apiErrorHandler(e)) {
        return;
      }
      return;
    }

    // todo 需要处理其他错误
    DioWrapper.handlerXtBizError(XTBizError.other(
        requestOptions: RequestOptions(baseUrl: url),
        code: "-1",
        reason: e.toString()));
  }

  Request._internal() {
    var options = BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15));
    _dio = Dio(options)
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        final token = CookieManager.getCookie() ?? "";
        options.headers["token"] = token;
        options.headers["version"] = "1.0.0";
        print("userTOken");
        print(token);
        print(options.headers["token"]);
        return handler.next(options);
      }));
  }
}

class DioWrapper {
  static void handlerXtBizError(XTBizError e) {
    if (e.type == XTErrorType.unauthorized) {
      logger.e("登录失效");
      // pushToLogin();
    } else {
      toastError(e.message);
    }
  }

  /*
   * error统一处理
   */
  static void handlerDioError(DioError e, {bool isProEnv = true}) {
    if (e.type == DioErrorType.connectionTimeout) {
      // It occurs when url is opened timeout.
      if (!isProEnv) {
        toastError("${e.message} ${e.requestOptions.path}");
        logger.e("连接超时");
      }
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      // It occurs when url is opened timeout.
      if (!isProEnv) {
        toastError("${e.message} ${e.requestOptions.path}");
        logger.e("请求超时");
      }
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      if (!isProEnv) {
        toastError("${e.message} ${e.requestOptions.path}");
        logger.e("响应超时");
      }
    } else if (e.type == DioErrorType.badCertificate) {
      // When the server response, but with a incorrect status, such as 404, 503...
      if (!isProEnv) {
        toastError("${e.message} ${e.requestOptions.path}");
        logger.e("出现异常");
      }
    } else if (e.type == DioErrorType.badResponse) {
      // When the request is cancelled, dio will throw a error with this type.
      logger.e("请求错误 ${e.message}");
    } else if (e.type == DioErrorType.connectionError) {
      logger.e("请求错误 ${e.message}");
    } else if (e.type == DioErrorType.cancel) {
      logger.e("取消 ${e.message}");
    } else if (e.type == DioErrorType.unknown) {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      logger.e("未知错误 ${e.message}");
      if (e.error is SocketException) {
        final socketException = e.error as SocketException;
        logger.e("未知错误 ${socketException.message}");
        if (socketException.message.startsWith("Failed host")) {}
      }
    }
  }

  static dynamic responseWrapper(Response response) {
    if (response.statusCode == 200) {
      /// 登录状态失效或者未登录
      final data = response.data;
      logger.d(data);
      if (data['code'] == 200) {
        return data['data'];
      } else if (data['code'] == 401) {
        throw XTBizError.unauthorized(
            requestOptions: response.requestOptions,
            code: "401",
            reason: "unauthorized");
      } else {
        throw XTBizError.other(
            requestOptions: response.requestOptions,
            code: data['code'].toString(),
            reason: data['errorMsg']);
      }
    } else if (response.statusCode == 401 || response.statusCode == 302) {
      logger.d(response);
      throw XTBizError.unauthorized(
          requestOptions: response.requestOptions,
          code: response.statusCode.toString(),
          reason: "unauthorized");
    } else {
      logger.d(response);
      throw XTBizError.other(
          // 其他 报错
          requestOptions: response.requestOptions,
          code: response.statusCode.toString(),
          reason: response.toString());
    }
  }
}
