import 'package:flutter/material.dart';

///路由监听
class MyNavObserver extends NavigatorObserver {
  void log(value) => debugPrint('MyNavObserver:$value');

  @override
  didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('didPush: ${route.settings.name}, previousRoute= ${previousRoute?.settings.name}');
  }

  @override
  didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('didPop: ${route.settings.name}, previousRoute= ${previousRoute?.settings.name}');
  }

  @override
  didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('didRemove: ${route.settings.name}, previousRoute= ${previousRoute?.settings.name}');
  }

  @override
  didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('didReplace: new= ${newRoute?.toString()}, old= ${oldRoute?.toString()}');
  }

  @override
  didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute,) {
    log('didStartUserGesture: ${route.toString()}, '
        'previousRoute= ${previousRoute?.toString()}');
  }

  @override
  didStopUserGesture() {
    log('didStopUserGesture');
  }
}
