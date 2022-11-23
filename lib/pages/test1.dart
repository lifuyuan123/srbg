import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Test1 extends StatefulWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  State<Test1> createState() => _Test1State();

}

var color;

class _Test1State extends State<Test1> {
  @override
  Widget build(BuildContext context) {
    color = Theme.of(context).primaryColor;
    return ListView(
      children: [
        //头部图片
        Image.asset('assets/ic_logo.png', fit: BoxFit.cover),
        //标题
        titleSection,
        //中间按钮
        buttonSection,
        //底部文字
        textSection
      ],
    );
  }
}

///标题部分
Widget titleSection = Container(
  padding: EdgeInsets.all(32.w), //容器padding 32
  child: Row(
    //子widget 一个横排
    children: [
      // 第一个widget 相当于linerlayout中得weight=1  铺满剩余空间
      Expanded(
          child: Column(
        //一个纵列
        crossAxisAlignment: CrossAxisAlignment.start, //代表左边对齐
        children: [
          Container(
            //这里使用容器是为了给出padding
            padding: EdgeInsets.only(bottom: 8.w),
            child: const Text(
              'Oeschinen Lake Campground',
              style: TextStyle(
                  //文字样式
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Text(
            'Kandersteg, Switzerland',
            style: TextStyle(color: Colors.grey[500]),
          )
        ],
      )),

      //横向剩下得widget
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),

      const Text('41')
    ],
  ),
);

///中间按钮
Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    icons(color, Icons.call, 'CALL'),
    icons(color, Icons.near_me, 'ROUTE'),
    icons(color, Icons.share, 'SHARE'),
  ],
);

///中间按钮  抽出每一个按钮widget
Column icons(Color color, IconData icon, String name) {
  return Column(
    mainAxisSize: MainAxisSize.min, //最小化
    mainAxisAlignment: MainAxisAlignment.center, //居中
    children: [
      Icon(
        icon,
        color: color,
      ),
      Container(
        margin: EdgeInsets.only(top: 8.w),
        child: Text(
          name,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: color),
        ),
      )
    ],
  );
}

///底部文字
Widget textSection = Padding(
  padding: EdgeInsets.all(32.w),
  child: const Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
    'Alps. Situated 1,578 meters above sea level, it is one of the '
    'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
    'half-hour walk through pastures and pine forest, leads you to the '
    'lake, which warms to 20 degrees Celsius in the summer. Activities '
    'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true, //自动换行
  ),
);
