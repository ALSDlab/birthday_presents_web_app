// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';

part 'order_model.g.dart';

@freezed
abstract class OrderModel with _$OrderModel {
  const factory OrderModel({
    @JsonKey(name: 'orderId') required String orderId,
    @JsonKey(name: 'productId') required String productId,
    @JsonKey(name: 'orderProductName') required String orderProductName,
    @JsonKey(name: 'representativeImage') required String representativeImage,
    @JsonKey(name: 'price') required String price,
    @JsonKey(name: 'count') required int count,
    @JsonKey(name: 'salesId') required int salesId,
    @JsonKey(name: 'orderedDate') String? orderedDate,
    @JsonKey(name: 'usedCouponPriceInOrder') num? usedCouponPriceInOrder,
    @JsonKey(name: 'personalInfoForDeliverChecked')
    bool? personalInfoForDeliverChecked,
    @JsonKey(name: 'ordererId') String? ordererId,
    @JsonKey(name: 'ordererName') String? ordererName,
    @JsonKey(name: 'ordererPhoneNo') String? ordererPhoneNo,
    @JsonKey(name: 'ordererAddress') String? ordererAddress,
    @JsonKey(name: 'ordererAddressDetail') String? ordererAddressDetail,
    @JsonKey(name: 'ordererPostcode') String? ordererPostcode,
    @JsonKey(name: 'payAndStatus')
    int? payAndStatus, // -1: 결제실패, 0: 결제전, 1: 결제완료, 2: 결제취소, 3: 배송중, 4: 배송완료
    @JsonKey(name: 'payAmount') int? payAmount,
    @JsonKey(name: 'paymentDate') String? paymentDate,
    @JsonKey(name: 'deletedDate') String? deletedDate,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
