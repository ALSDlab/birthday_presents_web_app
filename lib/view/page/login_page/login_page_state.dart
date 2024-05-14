import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/order_model.dart';

part 'login_page_state.freezed.dart';
part 'login_page_state.g.dart';

@freezed
class LoginPageState with _$LoginPageState {
  const factory LoginPageState({
    @Default(false) bool isLoading,
    @Default([]) List<OrderModel> orderItems,
  }) = _LoginPageState;

  factory LoginPageState.fromJson(Map<String, dynamic> json) =>
      _$LoginPageStateFromJson(json);
}
