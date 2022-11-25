import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:srbg/utils/Log.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../utils/CustomRoute.dart';
import 'Api.dart';
import 'dioManager.dart';

const String methodGet = 'get';
const String methodPost = 'post';
const String methodPut = 'put';

///网络统一请求工具
class HttpUtil {
  /// get 请求
  static Future get(String path,
      {Map<String, dynamic>? parmas,
      String baseUrl = '',
      bool isLoad = false,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    return sendRequest(methodGet, path, baseUrl, parmas, isLoad, options,
        cancelToken, onReceiveProgress);
  }

  /// post 请求
  static Future post(
    String path, {
    Map<String, dynamic>? parmas,
    String baseUrl = '',
    bool isLoad = false,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return sendRequest(methodPost, path, baseUrl, parmas, isLoad, options,
        cancelToken, onReceiveProgress);
  }

  /// post 请求
  static Future put(
    String path, {
    Map<String, dynamic>? parmas,
    String baseUrl = '',
    bool isLoad = false,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return sendRequest(methodPost, path, baseUrl, parmas, isLoad, options,
        cancelToken, onReceiveProgress);
  }

  ///统一发送请求预计返回值统一处理
  static Future sendRequest(
    String method,
    String path,
    String baseUrl,
    Map<String, dynamic>? parmas,
    bool isLoad,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ) async {
    var dio = DioManager().dio;

    //支持切换baseUrl
    if (!path.startsWith('http')) {
      dio.options.baseUrl = baseUrl.isNotEmpty ? baseUrl : Api.BASE_URL;
    }

    if (isLoad) {
      EasyLoading.show();
    }
    try {
      Response? rsp;
      if (method == methodGet) {
        rsp = await dio.get(path, queryParameters: parmas);
      } else if (method == methodPost) {
        rsp = await dio.post(path, data: parmas);
      } else if (method == methodPut) {
        rsp = await dio.put(path, data: parmas);
      }
      if (isLoad) {
        EasyLoading.dismiss();
      }
      if (rsp == null) {
        return {'code': -1, 'message': '', 'data': ''};
      }
      Log.v(rsp.data); //打印结果
      return handleResponse(rsp);
    } catch (err) {
      if (isLoad) {
        EasyLoading.dismiss();
      }
      return handleException(err);
    }
  }

  /// 统一处理解析数据
  static dynamic handleResponse(Response response) {
    if (isSuccess(response.statusCode)) {
      var code = response.data['code'];
      //token过期
      if (code == 2002 || code == 2000 || code == 2001 || code == 401) {
        Future.delayed(const Duration(seconds: 0)).then((value) {
          navigatorState.currentState
              ?.push(CustomRouteSlide(const LoginPage()));
        });
      }
      response.data;
    }
  }

  ///状态码是否成功
  static bool isSuccess(int? statusCode) {
    return (statusCode != null && statusCode >= 200 && statusCode < 300);
  }

  /// 统一处理异常-返回错误信息
  static dynamic handleException(ex) {
    var msg = '';
    if (ex is DioError) {
      switch (ex.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          msg = '网络超时';
          break;
        case DioErrorType.other:
          msg = '未知错误';
          break;
        case DioErrorType.response:
          int? statusCode = ex.response?.statusCode;
          switch (statusCode) {
            case 400:
              msg = '请求语法错误';
              break;
            case 401:
              msg = '没有权限';
              break;
            case 403:
              msg = '服务器拒绝执行';
              break;
            case 404:
              msg = '请求资源部存在';
              break;
            case 405:
              msg = '请求方法被禁止';
              break;
            case 500:
              msg = '服务器内部错误';
              break;
            case 502:
              msg = '无效请求';
              break;
            case 503:
              msg = '服务器异常';
              break;
            default:
              msg = '未知错误';
              break;
          }
          break;
        default:
          msg = '未知错误';
          break;
      }
    } else {
      msg = '未知错误';
    }
    return {'code': -1, 'message': msg, 'data': ''};
  }
}
