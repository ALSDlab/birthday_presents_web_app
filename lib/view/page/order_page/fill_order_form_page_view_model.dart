import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/user_model.dart';

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

  Future<void> saveOrdersInfo(
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
        'ordererId' : ordererId,
        'ordererName': ordererName,
        'ordererPhoneNo': ordererPhoneNo,
        'ordererAddress': ordererAddress,
        'ordererAddressDetail': ordererAddressDetail,
        'ordererPostcode': ordererPostcode,
        'isPayed': 0,
        'payAmount': int.parse(item.price.replaceAll(',', '')) * item.count,
        'paymentDate': ''
      },
    );
  }
}
