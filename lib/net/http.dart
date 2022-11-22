import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:srbg/utils/Log.dart';
import 'package:srbg/net/result_data.dart';
import 'package:srbg/utils/SpUtils.dart';

import 'address.dart';

class HttpManager {
  static final HttpManager _http = HttpManager._internal();
  Dio? _dio;
  String? token;

  factory HttpManager() {
    return _http;
  }

  static HttpManager getInstance({String? baseUrl}) {
    if (baseUrl == null) {
      return _http._normal();
    } else {
      return _http._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    _dio?.options.baseUrl = baseUrl;
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio?.options.baseUrl != Address.BASE_URL) {
      _dio?.options.baseUrl = Address.BASE_URL;
    }
    return this;
  }

  HttpManager._internal({String? baseUrl}) {
    if (null == _dio) {
      _dio = Dio();
      _dio!.options
        ..baseUrl = (null == baseUrl) ? Address.BASE_URL : baseUrl
        ..connectTimeout = 5 * 1000
        ..receiveTimeout = 5 * 1000
        ..validateStatus = (int? status) {
          return status != null && status > 0;
        };

      _dio?.interceptors.add(InterceptorsWrapper(
          // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
          // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
          onRequest: (options, handler) {
        if (token != null && token!.isNotEmpty) {
          SpUtils.getValue('token', "").then((value) {
            options.headers['token'] = token = value;
            return handler.next(options);
          });
        } else {
          Fluttertoast.showToast(msg: '没有token', backgroundColor: Colors.white70,textColor: Colors.black);
          options.headers['token'] = token;
          return handler.next(options);
        }
      }, onResponse: (response, handler) {
        SpUtils.setValue('token', 'asdfasdfasdfasdf432a4sd53f453asdfasdf');
        Log.e('assassinsSet');
        return handler.next(response);
      }, onError: (DioError e, handler) {
        return handler.next(e);
      }));
      _dio?.interceptors.add(LogInterceptor(requestBody: true));

      //https证书校验
      (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      };
    }
  }

  ///通用的GET请求
  get(api, {parmas, isLoading = true}) async {
    if (isLoading) {
      EasyLoading.show();
    }
    Response? response;
    try {
      response = await _dio!.get(api, queryParameters: parmas);
      if (isLoading) {
        EasyLoading.dismiss();
      }
    } on DioError catch (e) {
      if (isLoading) {
        EasyLoading.dismiss();
      }
      return ResultData(e.response?.data ? "" : e.response?.data!, false, 500);
    }

    return ResultData(response.data, response.statusCode == 200,
        response.statusCode == null ? 0 : response.statusCode!);
  }

  ///通用的POST请求
  post(api, {params, withLoading = true}) async {
    if (withLoading) {
      EasyLoading.show();
    }
    Response? response;
    try {
      response = await _dio!.post(api, data: params);
      if (withLoading) {
        EasyLoading.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        EasyLoading.dismiss();
      }
      return ResultData(e.response?.data ? "" : e.response?.data!, false, 500);
    }

    return ResultData(response.data, response.statusCode == 200,
        response.statusCode == null ? 0 : response.statusCode!);
  }
}
