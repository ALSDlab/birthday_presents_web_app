import 'package:daum_postcode_search/data_model.dart';

class FillOrderFormPageViewModel {
  final gridLeftArray = ['주문자', '휴대폰번호', '주소', '상세주소'];
  String address = '';
  DataModel? daumPostcodeSearchDataModel;
}