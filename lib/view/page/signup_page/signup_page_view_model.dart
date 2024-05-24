import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page_state.dart';

import '../../../utils/simple_logger.dart';

class SignupPageViewModel extends ChangeNotifier {
  SignupPageState _state = const SignupPageState();

  SignupPageState get state => _state;

  final gridLeftArray = [
    '아이디',
    '비밀번호',
    '비밀번호 확인',
    '이름',
    '휴대폰 번호',
    '주소',
    '',
    '상세주소'
  ];
  DataModel? daumPostcodeSearchDataModel;

  String _address = '';
  String _zoneCode = '';

  List<String> userArray = [];

  String get address => _address;

  String get zoneCode => _zoneCode;

  void setAddress(String newAddress, String newZoneCode) {
    _address = newAddress;
    _zoneCode = newZoneCode;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력하세요.';
    }
    if (value.length < 6) {
      return '6자리 이상 입력하세요';
    }
    return null;
  }

  Future saveUserInfo(
      String id,
      String name,
      String password,
      String phone,
      String postcode,
      String address,
      String addrDetail,
      int created,
      bool checked) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: '$id@gmail.com', password: password);
      await userCredential.user?.updateDisplayName(name);
    } catch (e) {
      return e.toString();
    }
    await FirebaseFirestore.instance
        .collection('user')
        .doc(created.toString() + id)
        .set({
      'id': id,
      'name': name,
      'phone': phone,
      'postcode': postcode,
      'address': address,
      'addressDetail': addrDetail,
      'created': created,
      'checked': checked,
    });
  }

  Future getUserArray() async {
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await FirebaseFirestore.instance.collection('user').get();

      for (var element in query.docs) {
        String userId = element.data()['id'];
        userArray.add(userId);
      }
    } catch (e) {
      logger.info('에러: $e');
      return false;
    }
  }

  void showSnackbar(BuildContext context, Widget content) {
    _state = state.copyWith(showSnackbarPadding: true);
    notifyListeners();

    final snackBar = SnackBar(
      content: content,
      duration: const Duration(seconds: 2),
      onVisible: () {
        // snackbar가 사라질 때 패딩을 제거합니다.
        Future.delayed(const Duration(milliseconds: 2200), () {
          _state = state.copyWith(showSnackbarPadding: false);
          notifyListeners();
        });
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
