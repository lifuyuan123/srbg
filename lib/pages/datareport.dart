import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srbg/utils/toast.dart';

import '../utils/color.dart';

///数据上报
class DateReportPage extends StatefulWidget {
  const DateReportPage({Key? key}) : super(key: key);

  @override
  State<DateReportPage> createState() => _DateReportPageState();
}

class _DateReportPageState extends State<DateReportPage> {
  final list = [
    const ReportBean(
        name: '工序作业',
        details: '上传循环作业数据，包括作业时间、工料机消耗数据。',
        icon: 'assets/ic_data_work.svg',
        iconbg: 'assets/ic_data_work_bg.svg',
        colorbg: MyColors.color_3CB9FF),
    const ReportBean(
        name: '施工安全',
        details: '上传一炮三检和动火作业数据。',
        icon: 'assets/ic_data_safe.svg',
        iconbg: 'assets/ic_data_safe_bg.svg',
        colorbg: MyColors.color_1ECDD2),
    const ReportBean(
        name: '循环数据',
        details: '上传隐蔽工程照片、地质照片和掌子面地质素描。',
        icon: 'assets/ic_data_image.svg',
        iconbg: 'assets/ic_data_image_bg.svg',
        colorbg: MyColors.color_6A79FF),
    const ReportBean(
        name: '预警管理',
        details: '上传有毒有害气体检测数据、瓦斯设备调校报备。',
        icon: 'assets/ic_data_warning.svg',
        iconbg: 'assets/ic_data_warning_bg.svg',
        colorbg: MyColors.color_FF7652),
    const ReportBean(
        name: '公共工序',
        details: '上传仰拱和二衬的作业数据。',
        icon: 'assets/ic_public_process.svg',
        iconbg: 'assets/ic_public_process_bg.svg',
        colorbg: MyColors.color_A56EFF),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          height: 44.w,
          child: const Center(
            child: Text(
              '数据上报',
              style: TextStyle(
                  fontSize: 16,
                  color: MyColors.color_2C2C2C,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: Center(
                child: ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return _child(list[i].name, list[i].details, list[i].icon,
                          list[i].iconbg, list[i].colorbg, i);
                    }),
              )),
        )
      ],
    );
  }

  Widget _child(String name, String details, String icon, String iconbg,
      Color colorbg, int i) {
    return Container(
      width: double.infinity,
      height: 116.w,
      padding: EdgeInsets.only(left: 10.w, top: 8.w, right: 10.w, bottom: 10.w),
      margin: EdgeInsets.only(left: 10.w, bottom: 10.w, right: 10.w),
      decoration: BoxDecoration(
          color: colorbg, borderRadius: BorderRadius.circular(10.w)),
      child: GestureDetector(
        onTap: () {
          Toast.toast(name);
          switch (i) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              break;
          }
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            SvgPicture.asset(iconbg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w, top: 2.2),
                  child: SvgPicture.asset(icon),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Text(
                        details,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReportBean {
  final String name;
  final String details;
  final String icon;
  final String iconbg;
  final Color colorbg;

  const ReportBean({
    required this.name,
    required this.details,
    required this.icon,
    required this.iconbg,
    required this.colorbg,
  });
}
