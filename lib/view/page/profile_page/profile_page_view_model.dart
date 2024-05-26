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
      debugPrint('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> saveProfileImage(XFile myPickedFile) async {
    final registerDate = DateTime.now().millisecondsSinceEpoch;
    final uploadRef = _auth
        .ref('profile/${currentUser.first.id}')
        .child('${registerDate}_${currentUser.first.id}.jpg');
    typed_data.Uint8List profileImage = await myPickedFile.readAsBytes();
    await uploadRef.putData(
        profileImage, SettableMetadata(contentType: "image/jpeg"));
    final downloadUrl = await uploadRef.getDownloadURL();

    try {
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
    } catch (e) {
      logger.info('Error saving profile image: $e');
    }
  }
}
