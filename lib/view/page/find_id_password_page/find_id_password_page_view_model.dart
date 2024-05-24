import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/find_id_password_page/find_id_password_state.dart';

import '../../../data/model/user_model.dart';
import '../../../domain/user_repository.dart';
import '../../../utils/simple_logger.dart';

class FindIdPasswordViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  FindIdPasswordViewModel({required this.userRepository});

  FindIdPasswordState _state = const FindIdPasswordState();

  FindIdPasswordState get state => _state;

  List<UserModel> currentUser = [];

  Future<String> findDocumentId(String name, String phoneNumber) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef = firestore.collection('user');
      QuerySnapshot querySnapshot = await collectionRef
          .where('name', isEqualTo: name)
          .where('phone', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document =
            await firestore.doc('user/${querySnapshot.docs.first.id}').get();
        return document.get('id');
      }
      return '';
    } catch (error) {
      logger.info('오류 발생: $error');
      return '';
    }
  }

  // 아이디로 검색해서 전화번호 데이터 받음
  // 반환값이 전화번호: 정상
  // 반환값이 '': 존재하지 않는 아이디
  // 반환값이 'error': 에러 발생
  Future<String> verifyInputData(String userId) async {
    try {
      currentUser = await userRepository.getFirebaseUserData(userId);

      if (currentUser.isNotEmpty) {
        return currentUser.first.phone;
      }
      return '';
    } catch (error) {
      logger.info('오류 발생: $error');
      return 'error';
    }
  }

  // 비밀번호 재설정 메서드
  Future<void> passwordUpdate(String newPassword) async {
    firebaseAuth.User? user = firebaseAuth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
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
