import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';

///登录
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // if (Platform.isAndroid) {//隐藏状态栏目
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
    // }

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/ic_login_bg.png'),
              fit: BoxFit.fill) //背景图
          ),
      child: Scaffold(
        //可滑动widget
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 165.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/ic_logo.png',
                        width: 52.w, height: 49.w),
                    Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: const Text('智慧隧道AI建造',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))),
                  ],
                )),
            Container(
              width: double.infinity, //无限大
              margin: EdgeInsets.only(top: 60.w, left: 12.w, right: 12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.w), //圆角
                child: Container(
                  padding: EdgeInsets.all(19.w),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 11.w),
                        child: const Text(
                          '登录',
                          style: TextStyle(
                              fontSize: 24, color: MyColors.color_4A4A4A),
                        ),
                      ),
                      SizedBox(
                        height: 40.w,
                      ),
                      input('账号', '请输入账号'),
                      SizedBox(
                        height: 15.w,
                      ),
                      input('密码', '请输入密码'),
                      //输入框
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

///两个输入框
ClipRRect input(String name, String hint) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(4.w), //圆角
    child:  Container(
        padding: EdgeInsets.only(left: 17.w, right: 17.w),
        color: MyColors.color_F8F8F8,
        child: Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                  fontSize: 16, color: MyColors.color_5F5F5F),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 12.w, horizontal: 10.w),
                    isCollapsed: true,
                    //相当于wrap
                    fillColor: MyColors.color_F8F8F8,
                    //填充色
                    filled: true,
                    //充满
                    hintText: hint,
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(4.w)
                    )
                ),
              ),
            )
          ],
        )),
  );
}
