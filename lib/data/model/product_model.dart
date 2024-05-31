import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'product_model.freezed.dart';

part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    @JsonKey(name: 'productId') required String productId,
    @JsonKey(name: 'representativeImage') required String representativeImage,
    @JsonKey(name: 'price') required String price,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'ingredients') required String ingredients,
    @JsonKey(name: 'images') required List<String> images,
    @JsonKey(name: 'salesId') required int salesId,
    @JsonKey(name: 'deliveryCost') required num deliveryCost,



  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}


