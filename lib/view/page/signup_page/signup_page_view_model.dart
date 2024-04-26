import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupViewModel {
  static final SignupViewModel _instance = SignupViewModel._internal();

  factory SignupViewModel() {
    return _instance;
  }

  SignupViewModel._internal();

  final gridLeftArray = ['아이디', '비밀번호', '비밀번호 확인', '이름', '휴대폰 번호', '주소'];
  DataModel? daumPostcodeSearchDataModel;

  String _address = '';
  String _zoneCode = '';

  String get address => _address;
  String get zoneCode => _zoneCode;

  void setAddress(String newAddress, String newZoneCode) {
    _address = newAddress;
    _zoneCode = newZoneCode;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력하세요.';
    }
    if (value.length < 6) {
      return '6자리 이상 입력하세요';
    }
    return null;
  }

  Future saveUserInfo(String id, String name, String password, String phone, String postcode, String address, String addrDetail, int created) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: id, password: password);
    } catch (e) {
      print(e);
    }
    await FirebaseFirestore.instance.collection('user').doc(created.toString() + id).set({
      'id': id,
      'name' : name,
      'phone' : phone,
      'postcode' : postcode,
      'address' : address,
      'addressDetail' : addrDetail,
      'created' : created,
    });
  }

  Future<bool> checkIfIdInUse(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
          .collection('user')
          .where('id', isEqualTo: id)
          .get();
      return query.docs.isNotEmpty; // 이미 사용 중
    } catch (e) {
      // ignore: avoid_print
      print('에러: $e');
      return false;
    }
  }


}