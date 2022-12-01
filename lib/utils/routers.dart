import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:srbg/notifier/userNotifier.dart';
import 'package:srbg/pages/home.dart';
import 'package:srbg/pages/login.dart';
import 'package:srbg/pages/test1.dart';
import 'package:srbg/utils/SpUtils.dart';
import 'package:srbg/utils/tags.dart';

import '../entry/user_bean_entity.dart';
import '../pages/mine.dart';
import 'CustomPage.dart';

///路由
class Routers {
  static final routers = GoRouter(initialLocation: '/', //初始化页面
      routes: [
        GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return CustomPage(context, state, const HomePage());
            },
            //拦截路由
            redirect: (BuildContext context, GoRouterState state) async {
              var json = await SpUtils.getString(Tags.USER_BEAN, '{}');
              final user = UserBeanData.fromJson(jsonDecode(json));
              print('拦截：$user');
              if (user.loginInfo?.token == null ||
                  user.loginInfo!.token!.isEmpty) {
                return '/login';
              } else {
                return null;
              }
            },
            routes: [
              GoRoute(
                  path: 'login',
                  pageBuilder: (context, state) {
                    return CustomPage(context, state, const LoginPage());
                  }),
              GoRoute(
                  path: 'test1',
                  pageBuilder: (context, state) {
                    return CustomPage(context, state, const Test1());
                  }),
              GoRoute(
                  path: 'mine',
                  pageBuilder: (context, state) {
                    return CustomPage(context, state, const MinePage());
                  }),
            ]),
      ]);
}
