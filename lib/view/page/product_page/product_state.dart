import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'product_state.freezed.dart';

part 'product_state.g.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(false) bool isLoading,
  }) = _ProductState;

  factory ProductState.fromJson(Map<String, Object?> json) =>
      _$ProductStateFromJson(json);
}