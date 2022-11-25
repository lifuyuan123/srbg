import 'package:go_router/go_router.dart';
import 'package:srbg/pages/home.dart';
import 'package:srbg/pages/login.dart';
import 'package:srbg/pages/test1.dart';

import 'CustomPage.dart';
///路由
class Routers {
  static final routers = GoRouter(initialLocation: '/', //初始化页面
      routes: [
        GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return CustomPage(context, state, const HomePage());
            }),
        GoRoute(
            path: '/login',
            pageBuilder: (context, state) {
              return CustomPage(context, state, const LoginPage());
            }),
        GoRoute(
            path: '/test1',
            pageBuilder: (context, state) {
              return CustomPage(context, state, const Test1());
            }),
      ]);
}
