import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/simple_logger.dart';

class CelllphoneVaildPageViewModel {
  static final CelllphoneVaildPageViewModel _instance =
      CelllphoneVaildPageViewModel._internal();

  factory CelllphoneVaildPageViewModel() {
    return _instance;
  }

  CelllphoneVaildPageViewModel._internal();

  String verificationNumber = '';
  Map<String, int> verificationTriedNumber = {};

  // 휴대폰 인증번호 생성하는 매서드 (랜덤숫자 6자리 형식)
  String generateVerificationNo() {
    // 4자리의 랜덤한 영문자 생성
    String numbers = '1234567890';
    String vNumber = '';
    Random random = Random();
    for (int i = 0; i < 6; i++) {
      vNumber += numbers[random.nextInt(10)];
    }
    return vNumber;
  }

  Future<void> sendVerificationCode(String servicePhoneNo, String phoneNumber) async {
    await updateVerificationPhoneNo(verificationTriedNumber, phoneNumber);

    // 실제로 문자 메시지를 발송하는 메서드 호출
    verificationNumber = generateVerificationNo();
    debugPrint('[민영기염소탕] 인증번호\n[$verificationNumber]');
    // sendSMS(
    //     servicePhoneNo, phoneNumber, '[민영기염소탕] 인증번호\n[$verificationNumber]');

    logger.info("Sending verification code...");
  }

  // 인증 휴대폰 번호, 인증시도 횟수 저장
  // 인증 휴대폰 및 시도횟수 불러오기
  Future<int> getVerificationPhoneNo(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    verificationTriedNumber =
        (prefs.getStringList('verificationPhoneNumber') ?? [])
            .asMap()
            .map((index, key) {
      int value = prefs.getInt(key) ?? 0;
      return MapEntry(key, value);
    });
    if (verificationTriedNumber.containsKey(phoneNumber)) {
      return verificationTriedNumber[phoneNumber]!;
    } else {
      return 0;
    }
  }

  // 인증 휴대폰 및 시도횟수 저장하기
  Future<void> saveVerificationPhoneNo(Map<String, int> myData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save keys
    await prefs.setStringList('verificationPhoneNumber', myData.keys.toList());
    // Save values
    for (var entry in myData.entries) {
      await prefs.setInt(entry.key, entry.value);
    }
  }

  // 저장된 데이터 추가 또는 신규저장
  Future<void> updateVerificationPhoneNo(Map<String, int> myData, String phoneNumber) async {
    if (myData.containsKey(phoneNumber)) {
      myData[phoneNumber] = myData[phoneNumber]! + 1;
    } else {
      myData[phoneNumber] = 1;
    }
    await saveVerificationPhoneNo(myData);
  }

  // 인증완료되면 저장된 데이터 삭제
  Future<void> clearVerificationPhoneNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    verificationTriedNumber.clear();
    prefs.remove('verificationPhoneNumber');
  }
}
