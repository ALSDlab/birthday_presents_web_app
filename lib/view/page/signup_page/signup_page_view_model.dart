import 'package:daum_postcode_search/data_model.dart';
import 'package:myk_market_app/view/page/signup_page/signup_state.dart';

class SignupViewModel {
  static final SignupViewModel _instance = SignupViewModel._internal();

  factory SignupViewModel() {
    return _instance;
  }

  SignupViewModel._internal();

  // SignupState state = const SignupState(address: 'wn', zoneCode: 'dn');
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


}