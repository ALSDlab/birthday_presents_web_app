import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/order_model.dart';
import '../../../data/model/shopping_cart_model.dart';
import '../../../data/model/user_model.dart';
import '../../../domain/user_repository.dart';
import 'edit_user_info_state.dart';

class EditUserInfoViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  EditUserInfoViewModel({
    required this.userRepository,
  }) {
    getUserList();
  }

  final gridLeftArray = ['이름', '휴대폰번호', '주 소', '', '상세주소'];
  Map<String, TextEditingController> controllers = {};
  DataModel? daumPostcodeSearchDataModel;

  List<UserModel> currentUser = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController extraAddressController = TextEditingController();

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
    extraAddressController.dispose();
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
    controllers['post'] = (postcodeController);
    addressController.text =
        (currentUser.isNotEmpty && state.addressChange == false)
            ? currentUser.first.address
            : (daumPostcodeSearchDataModel?.address) ?? address;
    controllers['address'] = (addressController);
    extraAddressController.text = (currentUser.isNotEmpty)
        ? currentUser.first.addressDetail
        : (extraAddressController.text);
    controllers['extraAddress'] = (extraAddressController);
    notifyListeners();
  }

  void addressChangeRequest() {
    _state = state.copyWith(addressChange: true);
    notifyListeners();
  }

  Future<bool> saveOrdersInfo(
    OrderModel item,
    String index,
    String currentDate,
    bool personalInfoForDeliverChecked,
    String ordererId,
    String ordererName,
    String ordererPhoneNo,
    String ordererAddress,
    String ordererAddressDetail,
    String ordererPostcode,
  ) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(item.orderId + item.productId)
          .set(
        {
          'orderId': item.orderId,
          'productId': item.productId,
          'orderProductName': item.orderProductName,
          'representativeImage': item.representativeImage,
          'price': item.price,
          'count': item.count,
          'orderedDate': item.orderedDate,
          'personalInfoForDeliverChecked': personalInfoForDeliverChecked,
          'ordererId': ordererId,
          'ordererName': ordererName,
          'ordererPhoneNo': ordererPhoneNo,
          'ordererAddress': ordererAddress,
          'ordererAddressDetail': ordererAddressDetail,
          'ordererPostcode': ordererPostcode,
          'payAndStatus': 0,
          'payAmount': int.parse(item.price.replaceAll(',', '')) * item.count,
          'paymentDate': '',
          'deletedDate': '',
        },
      );
    } catch (error) {
      // 에러 처리
      debugPrint('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
    return true;
  }

  Future<int> updateShoppingCart(List<OrderModel> orderItems) async {
    //TODO : 장바구니 비우기 적용(결제 할 것만)
    List<ShoppingProductForCart> currentList = await getShoppingCartList();
    List<String> orderIds = orderItems.map((e) => e.orderId).toSet().toList();
    currentList.removeWhere((e) => orderIds.contains(e.orderId));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(currentList.map((e) => e.toJson()).toList());
    prefs.setString('shoppingCartList', jsonString);
    return currentList.length;
  }

  Future<List<ShoppingProductForCart>> getShoppingCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedProducts = prefs.getString('shoppingCartList');

    if (selectedProducts != null) {
      // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환
      final jsonList = jsonDecode(selectedProducts) as List<dynamic>;
      final cartList =
          jsonList.map((e) => ShoppingProductForCart.fromJson(e)).toList();
      return cartList;
    } else {
      return [];
    }
  }
}
