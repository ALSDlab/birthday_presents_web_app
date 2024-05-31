import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/model/user_model.dart';
import '../../../domain/user_repository.dart';
import '../../../utils/simple_logger.dart';
import 'edit_user_info_state.dart';

class EditUserInfoViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  EditUserInfoViewModel({
    required this.userRepository,
  }) {
    getUserList();
  }

  final List<String> textField = [
    'name',
    'phone',
    'postcode',
    'address',
    'addressDetail'
  ];
  final gridLeftArray = ['이름', '휴대폰번호', '주 소', '', '상세주소'];
  Map<String, TextEditingController> controllers = {};
  DataModel? daumPostcodeSearchDataModel;

  List<UserModel> currentUser = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  EditUserInfoState _state = const EditUserInfoState();

  EditUserInfoState get state => _state;

  String _address = '';
  String _zoneCode = '';

  String get address => _address;

  String get zoneCode => _zoneCode;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    nameController.dispose();
    phoneController.dispose();
    postcodeController.dispose();
    addressController.dispose();
    addressDetailController.dispose();
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<void> getUserList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final String userId = FirebaseAuth.instance.currentUser!.email!
          .replaceAll('@gmail.com', '');
      int dotIndex = userId.indexOf('.');
      String currentUserId = userId.substring(dotIndex + 1);

      // logger.info(userId?.email!.replaceAll('@gmail.com', ''));
      currentUser = await userRepository.getFirebaseUserData(currentUserId);
      fillTextField();

      notifyListeners();
    } catch (error) {
      // 에러 처리
      debugPrint('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void setAddress(String newZoneCode, String newAddress) {
    _address = newAddress;
    _zoneCode = newZoneCode;
    notifyListeners();
  }

  void fillTextField() {
    nameController.text = ((currentUser.isNotEmpty)
        ? currentUser.first.name
        : (nameController.text));
    controllers['name'] = (nameController);
    phoneController.text = (currentUser.isNotEmpty)
        ? currentUser.first.phone
        : (phoneController.text);
    controllers['phone'] = (phoneController);
    postcodeController.text =
        (currentUser.isNotEmpty && state.addressChange == false)
            ? currentUser.first.postcode
            : (daumPostcodeSearchDataModel?.zonecode) ?? zoneCode;
    controllers['postcode'] = (postcodeController);
    addressController.text =
        (currentUser.isNotEmpty && state.addressChange == false)
            ? currentUser.first.address
            : (daumPostcodeSearchDataModel?.address) ?? address;
    controllers['address'] = (addressController);
    addressDetailController.text = ((currentUser.isNotEmpty)
        ? currentUser.first.addressDetail
        : (addressDetailController.text));
    controllers['addressDetail'] = (addressDetailController);
    notifyListeners();
  }

  void addressChangeRequest() {
    _state = state.copyWith(addressChange: true);
    notifyListeners();
  }

  bool checkUpdated() {
    for (var field in textField) {
      if (currentUser.first.toJson()[field] == controllers[field]!.text) {
        continue;
      } else {
        return true;
      }
    }
    return false;
  }



  // 유저정보 Update
  Future<void> updateUserInfo(UserModel updatedUserInfo) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(updatedUserInfo.created.toString() + updatedUserInfo.id)
          .update({
        'name': updatedUserInfo.name,
        'phone': updatedUserInfo.phone,
        'postcode': updatedUserInfo.postcode,
        'address': updatedUserInfo.address,
        'addressDetail': updatedUserInfo.addressDetail,
      });
    } catch (error) {
      // 에러 처리
      logger.info('Error post payInfo: $error');
    } finally {
      await getUserList();
      _state = state.copyWith(isLoading: false);
      notifyListeners();
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

