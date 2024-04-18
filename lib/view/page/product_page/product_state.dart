import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:myk_market_app/data/model/product_model.dart';

part 'product_state.freezed.dart';

part 'product_state.g.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default([]) List<Product> products,
    @Default(false) bool isLoading,
  }) = _ProductState;

  factory ProductState.fromJson(Map<String, Object?> json) => _$ProductStateFromJson(json);
}