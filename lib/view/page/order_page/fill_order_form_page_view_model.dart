import 'package:daum_postcode_search/data_model.dart';

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
}