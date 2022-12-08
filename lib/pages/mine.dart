import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:srbg/notifier/userNotifier.dart';
import 'package:srbg/utils/SpUtils.dart';
import 'package:srbg/utils/color.dart';
import 'package:srbg/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

///我的页面
class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  SizedBox(
                    height: 44.w,
                    child: const Center(
                      child: Text(
                        '我的',
                        style: TextStyle(
                            fontSize: 16,
                            color: MyColors.color_2C2C2C,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.w, left: 17.w, bottom: 17.w),
                    child: Row(
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://img1.baidu.com/it/u=1200248094,444329128&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=500',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(30.w)),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        SizedBox(
                          height: 60.w,
                          child: Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<UserNotifier>(
                                  builder: (context, user, child) {
                                return
                                  Text(
                                    '${user.userBeanData?.loginInfo?.userAccount}',
                                    style: const TextStyle(
                                        color: MyColors.color_2C2C2C,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)
                                  );
                              }),
                              SizedBox(
                                height: 2.w,
                              ),
                              Consumer<UserNotifier>(
                                  builder: (context, user, child) {
                                return Text(
                                    '${user.userBeanData?.loginInfo?.userName}',
                                    style: const TextStyle(
                                        color: MyColors.color_5F5F5F,
                                        fontSize: 14));
                              }),
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: EdgeInsets.only(left: 14.w, right: 14.w),
              margin: EdgeInsets.only(top: 10.w),
              child: Column(
                children: [
                  _item('assets/ic_location.svg', '项目定位', onclick, 0),
                  _item('assets/ic_tips.svg', '工区报停', onclick, 1),
                  _item('assets/ic_lock.svg', '修改密码', onclick, 2),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(top: 30.w),
              child: TextButton(
                style: ButtonStyle(//去除水波纹
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.transparent;
                })),
                onPressed: () {
                  Toast.toast('退出登录');
                  SpUtils.clearAll();
                  context.push('/login');
                  context.pop();
                },
                child: const Text(
                  '退出登录',
                  style: TextStyle(color: MyColors.color_E8575A, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.w),
          child: DefaultTextStyle(
              style:
                  const TextStyle(fontSize: 13, color: MyColors.color_5F5F5F),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: '《用户协议》',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final _url =
                          Uri.parse("https://lbs.amap.com/pages/privacy/");
                      if (!await launchUrl(_url)) {
                        throw 'Could not launch $_url';
                      }
                    },
                  style: const TextStyle(color: MyColors.color_6975FF),
                ),
                TextSpan(
                  text: '《隐私政策》',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final _url =
                          Uri.parse("https://www.jiguang.cn/license/privacy");
                      if (!await launchUrl(_url)) {
                        throw 'Could not launch $_url';
                      }
                    },
                  style: const TextStyle(color: MyColors.color_6975FF),
                ),
              ]))),
        )
      ],
    );
  }

  ///点击事件
  onclick(int position) {
    Toast.toast('$position');
    switch (position) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }

  Widget _item(String icon, String name, void Function(int position) function,
      int position) {
    return GestureDetector(
      onTap: () {
        function(position);
      },
      child: SizedBox(
        height: 47.w,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: SvgPicture.asset(
                icon,
              ),
            ),
            Expanded(
                child: Text(
              name,
              style:
                  const TextStyle(color: MyColors.color_2C2C2C, fontSize: 16),
            )),
            SvgPicture.asset(
              'assets/ic_next.svg',
            )
          ],
        ),
      ),
    );
  }
}
