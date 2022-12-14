import 'package:flutter/material.dart';

///传统路由动画
class CustomRouteSlide extends PageRouteBuilder {
  final Widget widget;

  CustomRouteSlide(this.widget)
      : super(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: animation1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
