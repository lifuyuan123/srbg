import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        body: Stack(
          children: [
            Positioned(
                top: 165.w,
                width: 375.w,
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
          ],
        ),
      ),
    );
  }
}
