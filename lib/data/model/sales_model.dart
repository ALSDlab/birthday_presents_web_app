import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'sales_model.freezed.dart';

part 'sales_model.g.dart';

@freezed
class SalesModel with _$SalesModel {
  const factory SalesModel({

    @JsonKey(name: 'salesId') required int salesId,
    @JsonKey(name: 'salesName') required String salesName,
    @JsonKey(name: 'salesAmount') required int salesAmount,
    @JsonKey(name: 'salesRate') required num salesRate,


  }) = _SalesModel;

  factory SalesModel.fromJson(Map<String, dynamic> json) => _$SalesModelFromJson(json);
}