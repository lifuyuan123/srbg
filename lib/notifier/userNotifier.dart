import 'package:flutter/material.dart';
import 'package:srbg/entry/user_bean_entity.dart';

class UserNotifier extends ChangeNotifier {

  UserNotifier(UserBeanData data){
    userBeanData=data;
  }

  UserBeanData? userBeanData ;

  UserBeanData? getUserBean() {
    return userBeanData;
  }

  void setUserBean(UserBeanData? userBeanData) {
    this.userBeanData = userBeanData;
    notifyListeners();
  }
}
