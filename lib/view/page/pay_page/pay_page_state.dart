import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myk_market_app/data/model/order_model.dart';

part 'pay_page_state.freezed.dart';part 'pay_page_state.g.dart';

@freezed
class PayPageState with _$PayPageState {
  const factory PayPageState({
    @Default([]) List<OrderModel> orderItems,
    @Default(false) bool showSnackbarPadding,
    @Default(false) bool isLoading,
  }) = _PayPageState;

  factory PayPageState.fromJson(Map<String, dynamic> json) =>
      _$PayPageStateFromJson(json);
}
