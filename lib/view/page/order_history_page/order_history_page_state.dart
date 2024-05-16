import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../data/model/order_model.dart';


part 'order_history_page_state.freezed.dart';

part 'order_history_page_state.g.dart';

@freezed
class OrderHistoryPageState with _$OrderHistoryPageState {
  const factory OrderHistoryPageState({
    @Default([]) List<List<OrderModel>> orderHistoryList,
    @Default(false) bool isLoading,
    @Default(true) bool isAscending,

  }) = _OrderHistoryPageState;

  factory OrderHistoryPageState.fromJson(Map<String, dynamic> json) => _$OrderHistoryPageStateFromJson(json);
}