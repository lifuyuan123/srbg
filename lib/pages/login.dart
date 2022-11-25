import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srbg/utils/SpUtils.dart';
import 'package:srbg/utils/tags.dart';
import '../entry/user_bean_entity.dart';
import '../net/service.dart';
import '../utils/color.dart';

///登录
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAgree = false;
  bool isShowPsw = false;
  bool isVisible = false;
  bool nameFocus = false;
  bool pswFocus = false;
  final nameControl = TextEditingController();
  final pswControl = TextEditingController();
  FocusNode namefocusNode = FocusNode();
  FocusNode pswfocusNode = FocusNode();

  // late Future<dynamic> login;

  @override
  void dispose() {
    nameControl.dispose();
    pswControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (Platform.isAndroid) {//隐藏状态栏目
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
    // }
    namefocusNode.addListener(() {
      setState(() {
        nameFocus = namefocusNode.hasFocus;
      });
    });
    pswfocusNode.addListener(() {
      setState(() {
        pswFocus = pswfocusNode.hasFocus;
      });
    });

    ///登录
    void login() async {
      var bean = await ServiceApi.login(nameControl.text, pswControl.text);
      SpUtils.setValue(Tags.TOKEN, bean.data?.loginInfo?.token);
    }

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/ic_login_bg.png'),
                fit: BoxFit.fill) //背景图
            ),
        //可滑动widget
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
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
                ),
                Container(
                  //无限大
                  margin: EdgeInsets.only(top: 60.w, left: 12.w, right: 12.w),
                  padding: EdgeInsets.all(19.w),
                  decoration: BoxDecoration(
                      //shape
                      borderRadius: BorderRadius.circular(8.w),
                      color: Colors.white),
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
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: nameFocus
                                    ? MyColors.color_6975FF
                                    : MyColors.color_E1E1E1,
                                width: 1.w),
                            borderRadius: BorderRadius.circular(4.w),
                            color: MyColors.color_F8F8F8),
                        child: Container(
                            padding: EdgeInsets.only(left: 17.w, right: 17.w),
                            // color: MyColors.color_F8F8F8,
                            child: Row(
                              children: [
                                const Text(
                                  '账号',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColors.color_5F5F5F),
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    obscureText: false,
                                    //隐藏密码
                                    onChanged: (v) {
                                      print('onChage: ${nameControl.text}');
                                    },
                                    controller: nameControl,
                                    focusNode: namefocusNode,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.w, horizontal: 10.w),
                                        isCollapsed: true,
                                        //相当于wrap
                                        fillColor: MyColors.color_F8F8F8,
                                        //填充色
                                        filled: true,
                                        //充满
                                        hintText: '请输入账号',
                                        hintStyle: const TextStyle(
                                            color: MyColors.color_805F5F5F),
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: pswFocus
                                    ? MyColors.color_6975FF
                                    : MyColors.color_E1E1E1,
                                width: 1.w),
                            borderRadius: BorderRadius.circular(4.w),
                            color: MyColors.color_F8F8F8),
                        child: Container(
                            padding: EdgeInsets.only(left: 17.w),
                            // color: MyColors.color_F8F8F8,
                            child: Row(
                              children: [
                                const Text(
                                  '密码',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColors.color_5F5F5F),
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    focusNode: pswfocusNode,
                                    obscureText: isShowPsw,
                                    //隐藏密码
                                    onChanged: (v) {
                                      setState(() {
                                        isVisible = pswControl.text.isNotEmpty;
                                      });
                                      print('onChage: ${pswControl.text}');
                                    },
                                    controller: pswControl,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.w, horizontal: 10.w),
                                        isCollapsed: true,
                                        //相当于wrap
                                        fillColor: MyColors.color_F8F8F8,
                                        //填充色
                                        filled: true,
                                        //充满
                                        hintText: '请输入密码',
                                        hintStyle: const TextStyle(
                                            color: MyColors.color_805F5F5F),
                                        border: InputBorder.none),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isShowPsw = !isShowPsw;
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      isShowPsw
                                          ? 'assets/ic_psw_show.svg'
                                          : 'assets/ic_psw_hide.svg',
                                      width: isVisible ? 18.w : 0.w,
                                      height: isVisible ? 13.w : 0.w,
                                    ))
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque, //整个区域
                        onTap: () {
                          //点击确认条款
                          setState(() {
                            isAgree = !isAgree;
                          });
                        },
                        child: Row(
                          children: [
                            StatefulBuilder(builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return SvgPicture.asset(
                                  isAgree
                                      ? 'assets/ic_tip_choice.svg'
                                      : 'assets/ic_tip_unchoice.svg',
                                  width: 16.w,
                                  height: 16.w);
                            }),
                            SizedBox(
                              width: 8.w,
                            ),
                            const DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 13, color: MyColors.color_5F5F5F),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: '我已同意并阅读'),
                                  TextSpan(
                                    text: '《用户协议》',
                                    style:
                                        TextStyle(color: MyColors.color_6975FF),
                                  ),
                                  TextSpan(text: '和'),
                                  TextSpan(
                                    text: '《隐私政策》',
                                    style:
                                        TextStyle(color: MyColors.color_6975FF),
                                  ),
                                ]))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50.w),
                        child: Container(
                          width: double.infinity,
                          height: 40.w,
                          decoration: BoxDecoration(
                              // border: Border.all(color: MyColors.color_E1E1E1, width: 1.w),
                              borderRadius: BorderRadius.circular(30.w),
                              color: MyColors.color_F8F8F8),
                          child: TextButton(
                            onPressed: () {
                              login();
                            },
                            style: ButtonStyle(overlayColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.transparent;
                            })),
                            child: const Text(
                              '登录',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
        // ),
        );
  }
}
