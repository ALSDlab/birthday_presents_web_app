import 'dart:convert';

import 'package:daum_postcode_search/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/user_model.dart';

class FillOrderFormPageViewModel {
  static final FillOrderFormPageViewModel _instance = FillOrderFormPageViewModel._internal();

  factory FillOrderFormPageViewModel() {
    return _instance;
  }

  FillOrderFormPageViewModel._internal();

  final gridLeftArray = ['주문자', '휴대폰번호', '주소', '상세주소'];
  DataModel? daumPostcodeSearchDataModel;

  String _address = '';
  String _zoneCode = '';

  String get address => _address;
  String get zoneCode => _zoneCode;

  void setAddress(String newAddress, String newZoneCode) {
    _address = newAddress;
    _zoneCode = newZoneCode;
  }

  static const String _key = 'userList';

  Future<List<User>> getUserList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? users = prefs.getString(_key);

    if (users != null) {
      // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환

      final jsonList = jsonDecode(users) as List<dynamic>;
      return jsonList.map((e) => User.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}