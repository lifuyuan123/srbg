import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:srbg/utils/SpUtils.dart';
import 'package:srbg/utils/tags.dart';
import 'package:srbg/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../net/service.dart';
import '../notifier/userNotifier.dart';
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
  bool canClick = false;
  bool isError = false;
  bool isFirst = true;

  //控制器一定要放在外层，否则setState的时候触发build方法重构会使textfield值恢复默认值
  TextEditingController nameControl = TextEditingController();
  TextEditingController pswControl = TextEditingController();

  final _shakeAnimationController = ShakeAnimationController();
  final _shakeAgreeController = ShakeAnimationController();

  var name = '';
  var psw = '';
  var oldname = '';
  var oldpsw = '';

  FocusNode namefocusNode = FocusNode();
  FocusNode pswfocusNode = FocusNode();

  @override
  void dispose() {
    nameControl.dispose();
    pswControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserNotifier>();

    //填充账号密码  取默认值要注意死循环
    // setState的时候触发build方法重构会使textfield值恢复默认值
    // 错误写法 psw = user.userBeanData?.loginInfo?.psw ?? '';
    name = isFirst ? user.userBeanData?.loginInfo?.userAccount ?? '' : name;
    psw = isFirst ? user.userBeanData?.loginInfo?.psw ?? '' : psw;
    oldname =
        isFirst ? user.userBeanData?.loginInfo?.userAccount ?? '' : oldname;
    oldpsw = isFirst ? user.userBeanData?.loginInfo?.psw ?? '' : oldpsw;
    isFirst = false;

    //首次进入判断是否显示隐藏密码按钮
    isVisible = psw.isNotEmpty;

    ///控制下标和填入账号密码
    nameControl.value = TextEditingValue(
        text: name,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: _chatIndex(name, oldname))));

    pswControl.value = TextEditingValue(
        text: psw,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: _chatIndex(psw, oldpsw))));

    ///控制焦点
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
    Future<bool> login() async {
      if (canClick) {
        var bean = await ServiceApi.login(name, psw);
        //更新底部提示显示
        setState(() {
          isError = bean.code != 200;
        });
        if (bean.code == 200) {
          Toast.toast('登录成功');
          //更新本地用户数据
          bean.data?.loginInfo?.psw = psw;
          user.setUserBean(bean.data);
          var userResult =
              await SpUtils.setString(Tags.USER_BEAN, bean.data?.toString());
          var tokenResult =
              await SpUtils.setString(Tags.TOKEN, bean.data?.loginInfo?.token);
          print('保存用户数据：user-$userResult   token-$tokenResult');

          return true;
        } else {
          //判断抖动动画是否正在执行
          if (_shakeAnimationController.animationRunging) {
            _shakeAnimationController.stop();
          } else {
            //开启抖动动画
            _shakeAnimationController.start(shakeCount: 1);
          }
        }
      } else {
        if (!isAgree && name.isNotEmpty && psw.isNotEmpty) {
          if (_shakeAgreeController.animationRunging) {
            _shakeAgreeController.stop();
          } else {
            //开启抖动动画
            _shakeAgreeController.start(shakeCount: 1);
          }
        } else {
          Toast.toast('请填写账号和密码');
        }
      }
      return false;
    }

    ///检查是否可点击
    void checkState() {
      canClick = isAgree && name.isNotEmpty && psw.isNotEmpty;
    }

    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //设置状态栏颜色
        statusBarIconBrightness: Brightness.dark,
      ));
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
              physics: const BouncingScrollPhysics(),
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
                                    onChanged: (v) {
                                      setState(() {
                                        isError = false;
                                      });
                                      oldname = name;
                                      name = v;
                                      setState(() {
                                        checkState();
                                      });
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
                                    obscureText: !isShowPsw,
                                    //隐藏密码
                                    onChanged: (v) {
                                      setState(() {
                                        isError = false;
                                      });
                                      oldpsw = psw;
                                      psw = v;
                                      if (isVisible != v.isNotEmpty) {
                                        setState(() {
                                          isVisible = v.isNotEmpty;
                                          checkState();
                                        });
                                      }
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
                                Visibility(
                                    visible: isVisible,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isShowPsw = !isShowPsw;
                                          });
                                        },
                                        icon: SvgPicture.asset(
                                          !isShowPsw
                                              ? 'assets/ic_psw_show.svg'
                                              : 'assets/ic_psw_hide.svg',
                                          width: 18.w,
                                          height: 13.w,
                                        )))
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
                            checkState();
                          });
                        },
                        child: ShakeAnimationWidget(
                            //抖动控制器
                            shakeAnimationController: _shakeAgreeController,
                            //微旋转的抖动
                            shakeAnimationType:
                                ShakeAnimationType.LeftRightShake,
                            //设置不开启抖动
                            isForward: false,
                            //默认为 0 无限执行
                            shakeCount: 0,
                            //抖动的幅度 取值范围为[0,1]
                            shakeRange: 0.3,
                            //执行抖动动画的子Widget
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                DefaultTextStyle(
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: MyColors.color_5F5F5F),
                                    child: Text.rich(TextSpan(children: [
                                      const TextSpan(text: '我已同意并阅读'),
                                      TextSpan(
                                        text: '《用户协议》',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final _url = Uri.parse(
                                                "https://lbs.amap.com/pages/privacy/");
                                            if (!await launchUrl(_url)) {
                                              throw 'Could not launch $_url';
                                            }
                                          },
                                        style: const TextStyle(
                                            color: MyColors.color_6975FF),
                                      ),
                                      const TextSpan(text: '和'),
                                      TextSpan(
                                        text: '《隐私政策》',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final _url = Uri.parse(
                                                "https://www.jiguang.cn/license/privacy");
                                            if (!await launchUrl(_url)) {
                                              throw 'Could not launch $_url';
                                            }
                                          },
                                        style: const TextStyle(
                                            color: MyColors.color_6975FF),
                                      ),
                                    ]))),
                              ],
                            )),
                      ),
                      Visibility(
                          visible: isError,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.w),
                            child: SizedBox(
                              width: double.infinity,
                              child: ShakeAnimationWidget(
                                //抖动控制器
                                shakeAnimationController:
                                    _shakeAnimationController,
                                //微旋转的抖动
                                shakeAnimationType:
                                    ShakeAnimationType.LeftRightShake,
                                //设置不开启抖动
                                isForward: false,
                                //默认为 0 无限执行
                                shakeCount: 0,
                                //抖动的幅度 取值范围为[0,1]
                                shakeRange: 0.3,
                                //执行抖动动画的子Widget
                                child: const Text(
                                  '账号或密码错误！',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: MyColors.color_E8575A),
                                ),
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 50.w),
                        child: Container(
                          width: double.infinity,
                          height: 40.w,
                          decoration: BoxDecoration(
                              // border: Border.all(color: MyColors.color_E1E1E1, width: 1.w),
                              borderRadius: BorderRadius.circular(30.w),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: canClick
                                      ? [
                                          MyColors.color_6A79FF,
                                          MyColors.color_5E6CF1
                                        ]
                                      : [
                                          MyColors.color_C9C7C7,
                                          MyColors.color_A4A2A2
                                        ]),
                              color: MyColors.color_F8F8F8),
                          child: TextButton(
                            onPressed: () {
                              login().then((value) {
                                if (value) {
                                  if (context.canPop()) {
                                    context.pop();
                                  } else {
                                    context.push('/');
                                    context.pop();
                                  }
                                }
                              });
                            },
                            style: ButtonStyle(overlayColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.transparent;
                            })),
                            child: const Text(
                              '登录',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
        ));
  }

  //记录下标位置
  int _chatIndex(String str, String oldStr) {
    final isAdd = str.length > oldStr.length;
    var len = isAdd ? oldStr.length : str.length;
    final chars = str.characters;
    final oldchars = oldStr.characters;
    for (int i = 0; i < len; i++) {
      if (oldchars.characterAt(i).string != chars.characterAt(i).string) {
        return isAdd ? i + 1 : i;
      }
    }
    return str.length;
  }
}
