import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:srbg/entry/user_bean_entity.dart';
import 'Api.dart';
import 'httpUtils.dart';

///统一请求中心
class ServiceApi {


  ///登录
  static Future<UserBeanEntity> login(String name, String psw) async {
    final content = const Utf8Encoder().convert(psw);
    String pswMd5 = md5.convert(content).toString();
    var result = await HttpUtil.sendRequest(methodPost, Api.login,
        parmas: {'userAccount': name, 'userPwd': pswMd5}, isLoad: true);
    return UserBeanEntity.fromJson(result);
  }
}
