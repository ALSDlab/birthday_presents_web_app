import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'product_detail_page_state.freezed.dart';

part 'product_detail_page_state.g.dart';

@freezed
class ProductDetailPageState with _$ProductDetailPageState {
  const factory ProductDetailPageState({
    @Default(false)isLoading,
    @Default(1)count,
  }) = _ProductDetailPageState;

  factory ProductDetailPageState.fromJson(Map<String, Object?> json) => _$ProductDetailPageStateFromJson(json);
}