import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'coupons_model.freezed.dart';

part 'coupons_model.g.dart';

@freezed
class CouponsModel with _$CouponsModel {
  const factory CouponsModel({
    @JsonKey(name: 'couponId') required int couponId,
    @JsonKey(name: 'couponName') required String couponName,
    @JsonKey(name: 'dcAmount') required int dcAmount,
    @JsonKey(name: 'dcRate') required num dcRate,

  }) = _CouponsModel;

  factory CouponsModel.fromJson(Map<String, dynamic> json) => _$CouponsModelFromJson(json);
}