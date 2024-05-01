import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/user_model.dart';
import 'fill_order_form_page_state.dart';

class FillOrderFormPageViewModel extends ChangeNotifier {
  static final FillOrderFormPageViewModel _instance =
      FillOrderFormPageViewModel._internal();

  factory FillOrderFormPageViewModel() {
    return _instance;
  }

  FillOrderFormPageViewModel._internal();

  final gridLeftArray = ['주문자', '휴대폰번호', '주소', '상세주소'];
  DataModel? daumPostcodeSearchDataModel;

  String _address = '';
  String _zoneCode = '';
  List<User> _currentUser = [];

  String get address => _address;

  String get zoneCode => _zoneCode;

  List<User> get currentUser => _currentUser;

  FillOrderFormPageState _state = const FillOrderFormPageState();

  FillOrderFormPageState get state => _state;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  void setAddress(String newAddress, String newZoneCode) {
    _address = newAddress;
    _zoneCode = newZoneCode;
    notifyListeners();
  }

  static const String _key = 'userList';

  Future<void> getUserList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? users = prefs.getString(_key);

    if (users != null) {
      // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환

      final jsonList = jsonDecode(users) as List<dynamic>;
      _currentUser = jsonList.map((e) => User.fromJson(e)).toList();
    } else {
      _currentUser = [];
    }
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
          .doc(item.orderId + index)
          .set(
        {
          'orderId': item.orderId,
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
          'paymentDate': ''
        },
      );
    } catch (error) {
      // 에러 처리
      debugPrint('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
    return true;
  }
}
