// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
abstract class OrderModel with _$OrderModel {
  const factory OrderModel({
    @JsonKey(name: 'orderId') required String orderId,
    @JsonKey(name: 'orderProductName') required String orderProductName,
    @JsonKey(name: 'representativeImage') required String representativeImage,
    @JsonKey(name: 'price') required String price,
    @JsonKey(name: 'count') required int count,
    @JsonKey(name: 'orderedDate') String? orderedDate,
    @JsonKey(name: 'orderFormAgreement') bool? orderFormAgreement,
    @JsonKey(name: 'ordererId') String? ordererId,
    @JsonKey(name: 'ordererName') String? ordererName,
    @JsonKey(name: 'ordererPhoneNo') String? ordererPhoneNo,
    @JsonKey(name: 'ordererAddress') String? ordererAddress,
    @JsonKey(name: 'ordererAddressDetail') String? ordererAddressDetail,
    @JsonKey(name: 'ordererPostcode') String? ordererPostcode,
    @JsonKey(name: 'isPayed') bool? isPayed,
    @JsonKey(name: 'paymentDate') String? paymentDate,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
