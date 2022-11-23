import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast{
  static void toast(String msg){
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.white70,textColor: Colors.black);
  }
}