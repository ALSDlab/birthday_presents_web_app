import 'package:daum_postcode_search/data_model.dart';

class SignupViewModel {
  final gridLeftArray = ['아이디', '비밀번호', '비밀번호 확인', '이름', '휴대폰 번호', '주소'];
  String address = '';
  DataModel? daumPostcodeSearchDataModel;
}