import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srbg/pages/test1.dart';
import 'package:srbg/utils/color.dart';
import '../utils/keepAliveWrapper.dart';
import '../utils/toast.dart';
import 'datareport.dart';
import 'mine.dart';

final navigatorState = GlobalKey<NavigatorState>();

///首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController();
  DateTime? _lastTime;
  int _index = 0;
  // final views = [
  //   const KeepAliveWrapper(keepAlive: true, child: Test1()),
  //   const KeepAliveWrapper(keepAlive: true, child: DateReportPage()),
  //   const KeepAliveWrapper(keepAlive: true, child: MinePage())
  // ];
  final views = [
     const Test1(),
     const DateReportPage(),
     const MinePage()
  ];

  @override
  Widget build(BuildContext context) {

    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white, //设置状态栏颜色
        statusBarIconBrightness: Brightness.dark,
      ));
    }

    return MaterialApp(
      navigatorKey: navigatorState,
      home: Scaffold(
        backgroundColor: MyColors.color_F5F5F5, //全局背景色
        body: WillPopScope(
          onWillPop: () async {
            if (_lastTime == null ||
                DateTime.now().difference(_lastTime!) >
                    const Duration(seconds: 1)) {
              _lastTime = DateTime.now();
              Toast.toast('再点击一次退出app');
              return false;
            }
            return true;
          },
          child: SafeArea(
              top: true,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    _index = index;
                  });
                },
                itemCount: views.length,
                physics: const NeverScrollableScrollPhysics(),
                //禁止左右滑动
                itemBuilder: (contex, index) {
                  return views[index];
                }, //禁止滑动
              )),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (index) {
              if (_index != index) {
                controller.jumpToPage(index); // PageView 展示对应 Tab
                setState(() {
                  _index = index; // 更新选中的Tab位置
                });
              }
            },
            unselectedFontSize: 10,
            selectedFontSize: 10,
            selectedItemColor: MyColors.color_6A79FF,
            unselectedItemColor: MyColors.color_5F5F5F,
            items: [
              bottomItem('首页', 'assets/ic_home.svg', 0, _index),
              bottomItem('数据上报', 'assets/ic_datareport.svg', 1, _index),
              bottomItem('我的', 'assets/ic_personal.svg', 2, _index),
            ],
            type: BottomNavigationBarType.fixed, // 设置未选中也能显示标题
          ),
        ),
      ),
    );
  }
}

///tabItem
BottomNavigationBarItem bottomItem(
    String name, String icon, int index, int choiceIndex) {
  return BottomNavigationBarItem(
      icon: SvgPicture.asset(icon,
          color: choiceIndex == index
              ? MyColors.color_6A79FF
              : MyColors.color_9E9E9E,
          width: 19.w,
          height: 19.w),
      label: name);
}
