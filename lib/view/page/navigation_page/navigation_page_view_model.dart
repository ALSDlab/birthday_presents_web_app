import 'dart:math';

import 'package:flutter/material.dart';

import 'globals.dart';

class NavigationPageViewModel with ChangeNotifier {
  int badgeCount = 0;
  bool isHideNavBar = false;


  bool resetNavigation(int newCount) {
    badgeCount = newCount;
    notifyListeners();
    return true;
  }

  bool hideNavBar(bool newValue) {
    isHideNavBar = newValue;
    notifyListeners();
    return isHideNavBar;
  }

  void setNameAndBirthYear(String nameValue, int birthYearValue) {
    Globals.name = nameValue;
    Globals.birthYear = birthYearValue;
  }

  // 문서ID 생성하는 매서드 (영문 대소문자,숫자 10자리 조합)
  void generateDocId() {
    // 4자리의 랜덤한 영문자 생성
    String letters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    for (int i = 0; i < 15; i++) {
      Globals.docId += letters[random.nextInt(62)];
    }
  }
}
