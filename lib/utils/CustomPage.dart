import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

///gorouter 转场动画
class CustomPage extends CustomTransitionPage {
  final Widget widget;
  final BuildContext context;
  final GoRouterState state;

  CustomPage(this.context, this.state, this.widget)
      : super(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 400),
            child: widget,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
