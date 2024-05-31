import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page_state.dart';

import '../../../domain/user_repository.dart';
import '../../../utils/simple_logger.dart';

class SignupPageViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  SignupPageViewModel({required this.userRepository}) {
    getEmailsFromFirestore();
  }

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

  void setAddress(String newZoneCode, String newAddress) {
    _address = newAddress;
    _zoneCode = newZoneCode;
    notifyListeners();
  }

  // 회원가입 시 사용된 이메일 리스트 불러오기
  Future<void> getEmailsFromFirestore() async {
    try {
      _state = state.copyWith(isLoading: true);
      notifyListeners();
      List<String> emails = await userRepository.getUsedEmails();
      _state = state.copyWith(existingEmails: emails);
      notifyListeners();
    } catch (e) {
      logger.info('Error fetching emails: $e');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      notifyListeners();
      return '비밀번호를 입력하세요.';
    }
    if (value.length < 6) {
      notifyListeners();
      return '6자리 이상 입력하세요';
    }
    notifyListeners();
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
      int recreatCount,
      bool checked,
      List<int> coupons,
      int verificationLimit) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final String saveUserEmail = '$recreatCount.$id@gmail.com';
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: saveUserEmail, password: password);
      await userCredential.user?.updateDisplayName(name);
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
        'recreatCount': recreatCount,
        'profileImage': '',
      'coupons': coupons,
      'verificationLimit': verificationLimit
      });
      // used_emails에 저장하기
      await userRepository.addEmailToFirestore(saveUserEmail);
      notifyListeners();
    } catch (error) {
      logger.info('오류 발생: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future getUserArray() async {
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await FirebaseFirestore.instance.collection('user').get();

      for (var element in query.docs) {
        String userId = element.data()['id'];
        userArray.add(userId);
        notifyListeners();
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

  bool idValidator(String id) {
    for (String email in state.existingEmails) {
      final String splitedEmail = email.split('@').first;
      int firstDotIndex = splitedEmail.indexOf('.');
      if (firstDotIndex != -1) {
        final String resultString = splitedEmail.substring(firstDotIndex + 1);
        if (resultString == id) {
          return false;
        }
      }
    }
    return true;
  }
}
