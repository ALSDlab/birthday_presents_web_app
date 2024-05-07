import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';

part 'shopping_cart_state.freezed.dart';

part 'shopping_cart_state.g.dart';

@freezed
class ShoppingCartState with _$ShoppingCartState {
  const factory ShoppingCartState({
    @Default([]) List<ShoppingProductForCart> cartList,
    @Default(false) bool isLoading,
  }) = _ShoppingCartState;

  factory ShoppingCartState.fromJson(Map<String, Object?> json) =>
      _$ShoppingCartStateFromJson(json);
}
