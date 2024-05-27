import 'dart:typed_data' as typed_data;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myk_market_app/view/page/profile_page/profile_page_state.dart';

import '../../../data/model/user_model.dart';
import '../../../domain/user_repository.dart';
import '../../../utils/simple_logger.dart';

class ProfilePageViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  ProfilePageViewModel({
    required this.userRepository,
  }) {
    getUserList();
  }

  List<UserModel> currentUser = [];
  final ImagePicker picker = ImagePicker();
  final _auth = FirebaseStorage.instance;

  ProfilePageState _state = const ProfilePageState();

  ProfilePageState get state => _state;

  Future<void> getUserList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final String userId = FirebaseAuth.instance.currentUser!.email!
          .replaceAll('@gmail.com', '');
      int dotIndex = userId.indexOf('.');
      String currentUserId = userId.substring(dotIndex + 1);
      currentUser = await userRepository.getFirebaseUserData(currentUserId);
      notifyListeners();
    } catch (error) {
      // 에러 처리
      logger.info('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> saveProfileImage(XFile myPickedFile) async {
    try {
      _state = state.copyWith(isLoading: true);
      notifyListeners();

      final registerDate = DateTime.now().millisecondsSinceEpoch;
      final uploadRef = _auth
          .ref('profile/${currentUser.first.id}')
          .child('${registerDate}_${currentUser.first.id}.jpg');
      typed_data.Uint8List profileImage = await myPickedFile.readAsBytes();
      await uploadRef.putData(
          profileImage, SettableMetadata(contentType: "image/jpeg"));
      final downloadUrl = await uploadRef.getDownloadURL();

      // Firestore에서 `id` 필드 확인
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('id', isEqualTo: currentUser.first.id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // `id`가 존재할 때, 추가 데이터 저장
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({'profileImage': downloadUrl});
      }
      notifyListeners();
    } catch (e) {
      logger.info('Error saving profile image: $e');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> userWithdrawalProcess(String userId) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      // 유저정보 삭제
      await userRepository.deleteFirebaseUserData(userId);
      String folderPath = 'profile/$userId';
      // storage 파일 삭제
      await deleteFolder(folderPath);
    } catch (error) {
      logger.info('오류 발생: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> deleteFolder(String folderPath) async {
    // 폴더 내의 모든 파일을 참조
    ListResult result = await _auth.ref(folderPath).listAll();
    // 폴더 내의 모든 파일을 삭제
    for (Reference file in result.items) {
      await file.delete();
    }
    // 폴더 내의 모든 하위 폴더를 참조
    for (Reference folder in result.prefixes) {
      await deleteFolder(folder.fullPath); // 재귀적으로 하위 폴더도 삭제
    }
    // 폴더 자체는 Firebase Storage에서 자동으로 제거됩니다 (비어있으면 자동으로 제거됨).
  }
}
