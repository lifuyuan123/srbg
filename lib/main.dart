import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:srbg/notifier/userNotifier.dart';
import 'package:srbg/utils/SpUtils.dart';
import 'package:srbg/utils/color.dart';
import 'package:srbg/utils/routers.dart';
import 'package:srbg/utils/tags.dart';
import 'entry/user_bean_entity.dart';

void main() async {
  //不加这句sp报初始化错误
  WidgetsFlutterBinding.ensureInitialized();
  //获取本地用户数据
  var json = await SpUtils.getString(Tags.USER_BEAN, '{}');
  final user = UserBeanData.fromJson(jsonDecode(json));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserNotifier(user), //本地用户数据赋值
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white, //设置状态栏颜色
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
            routerConfig: goRouter,
              theme: ThemeData(
                primarySwatch: Colors.blue, primaryColor: Colors.white
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
