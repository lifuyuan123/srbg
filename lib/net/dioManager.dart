import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:srbg/utils/Log.dart';
import 'package:srbg/utils/SpUtils.dart';
import 'package:srbg/utils/toast.dart';

import '../utils/tags.dart';
import 'Api.dart';

class DioManager {
  static final DioManager instance = DioManager._internal();
  late Dio dio;
  String? token;

  factory DioManager() => instance;

  static DioManager getInstance({String? baseUrl}) {
    if (baseUrl == null) {
      return instance._normal();
    } else {
      return instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  DioManager _baseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    return this;
  }

  //一般请求，默认域名
  DioManager _normal() {
    if (dio.options.baseUrl != Api.BASE_URL) {
      dio.options.baseUrl = Api.BASE_URL;
    }
    return this;
  }

  DioManager._internal() {
    initDio();
  }

  void initDio() {
    dio = Dio();
    dio.options
      ..baseUrl = Api.BASE_URL
      ..connectTimeout = 5 * 1000
      ..receiveTimeout = 5 * 1000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      };

    dio.interceptors.add(InterceptorsWrapper(
        // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
        onRequest: (options, handler) {
      if (token == null || token!.isNotEmpty) {
        SpUtils.getValue(Tags.TOKEN, "").then((value) {
          options.headers[Tags.TOKEN] = token = value;
          return handler.next(options);
        });
      } else {
        options.headers[Tags.TOKEN] = token;
        return handler.next(options);
      }
    }, onResponse: (response, handler) {
      Log.e('token:$token');
      return handler.next(response);
    }, onError: (DioError e, handler) {
      Toast.toast(e.message);
      return handler.reject(e);
    }));
    dio.interceptors.add(LogInterceptor(requestBody: true));

    //https证书校验
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return null;
    };
  }
}
