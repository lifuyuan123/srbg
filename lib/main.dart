import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:srbg/pages/test1.dart';
import 'package:srbg/utils/CustomRoute.dart';
import 'package:srbg/net/Api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'entry/Album.dart';
import 'pages/login.dart';

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

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              routes: <String, WidgetBuilder>{
                'login': (context) => const LoginPage()
              },
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const Scaffold(
                body: Center(
                  child: RandomWords(),
                ),
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

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();

    ///网络请求
    futureAlbum = fetchAlbum();
  }

  //跳转收藏夹
  void _pushSaved() {
    // Navigator.of(context).push(CustomRouteSlide(_collectWidget())
    Navigator.of(context).push(CustomRouteSlide(const LoginPage()));
    //跳转页面
    // Navigator.of(context).push(CustomRouteSlide(const Test1()));
  }

  @override
  Widget build(BuildContext context) {
    return _pushWidget();
  }

  ///网络请求数据
  Widget _pushWidget() {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
          systemOverlayStyle: SystemUiOverlayStyle.dark, //状态栏字体颜色
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: Center(
          ///处理网络数据
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('${snapshot.data!.userId}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const Text('');
            },
          ),
        ));
  }
}
