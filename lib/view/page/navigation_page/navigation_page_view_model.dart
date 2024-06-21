import 'dart:math';

import 'package:flutter/material.dart';

class NavigationPageViewModel with ChangeNotifier {
  int badgeCount = 0;
  bool isHideNavBar = false;
  String docId = '';
  String name = '';
  int birthYear = 0;

  bool resetNavigation(int newCount) {
    badgeCount = newCount;
    notifyListeners();
    return true;
  }

  bool hideNavBar(bool newValue) {
    isHideNavBar = newValue;
    notifyListeners();
    return true;
  }

  void setNameAndBirthYear(String nameValue, int birthYearValue) {
    name = nameValue;
    birthYear = birthYearValue;
  }

  // 문서ID 생성하는 매서드 (영문 대소문자,숫자 10자리 조합)
  void generateDocId() {
    // 4자리의 랜덤한 영문자 생성
    String letters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    for (int i = 0; i < 15; i++) {
      docId += letters[random.nextInt(62)];
    }
  }
}
