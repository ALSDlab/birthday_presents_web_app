import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';

part 'product_detail_page_state.freezed.dart';

part 'product_detail_page_state.g.dart';

@freezed
class ProductDetailPageState with _$ProductDetailPageState {
  const factory ProductDetailPageState({
    @Default(false) bool isLoading,
    @Default(false) bool showSnackbarPadding,
    @Default([]) List<ShoppingProductForCart> forBadgeList,
  }) = _ProductDetailPageState;

  factory ProductDetailPageState.fromJson(Map<String, Object?> json) => _$ProductDetailPageStateFromJson(json);
}