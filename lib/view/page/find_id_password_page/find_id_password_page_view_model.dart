import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
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
      print(currentUser.first.id);
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

  // 유저데이터 삭제하고 재가입되는 방식으로 비밀번호를 변경함(Firebase Auth에는 그대로 남아있음)
  Future<UserModel?> getUserModelById(String userId) async {
    try {
      // 아이디로 유저정보 확인
      currentUser = await userRepository.getFirebaseUserData(userId);

      if (currentUser.isNotEmpty) {
        return currentUser.first;
      }
    } catch (error) {
      logger.info('오류 발생: $error');
    }
    return null;
  }

  // 기존 유저 데이터는 삭제하고 재가입함
  Future<void> deleteAndResignup(String userId, String newPassword) async {
    final userData = await getUserModelById(userId);
    try {
      if (userData != null) {
        // TODO:기존에 있던 데이터는 삭제함
        await userRepository.deleteFirebaseUserData(userId);

        await saveUserInfo(
            userData.id,
            userData.name,
            newPassword,
            userData.phone,
            userData.postcode,
            userData.address,
            userData.addressDetail,
            DateTime.now().millisecondsSinceEpoch,
            userData.recreatCount + 1,
            userData.checked);

        firebase_auth.FirebaseAuth.instance.signOut();
      }
    } catch (error) {
      logger.info('오류 발생: $error');
    }
  }

// 유저정보를 Firebase에 저장
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
      bool checked) async {
    try {
      firebase_auth.UserCredential userCredential = await firebase_auth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: '$recreatCount.$id@gmail.com', password: password);
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
      'recreatCount': recreatCount,
    });
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
