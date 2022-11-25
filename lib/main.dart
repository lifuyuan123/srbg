import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:srbg/utils/routers.dart';

void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //设置状态栏颜色
        statusBarIconBrightness: Brightness.dark,
      ));
    }
    final easyload = EasyLoading.init(); //加载框
    final goRouter = Routers.routers;

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
              routerDelegate: goRouter.routerDelegate,
              routeInformationParser: goRouter.routeInformationParser,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              builder: (context, child) {
                child = easyload(context, child); //初始化加载框
                child = Scaffold(
                  body: GestureDetector(
                      //手势操作widget
                      onTap: () {
                        hideKeyboard(context); //全局处理软键盘
                      },
                      child: child),
                );
                return child;
              });
        });
  }
}

///隐藏软键盘
void hideKeyboard(BuildContext context) {
  FocusScopeNode focus = FocusScope.of(context);
  if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

