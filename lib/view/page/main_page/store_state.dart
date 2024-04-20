import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myk_market_app/data/model/store_model.dart';

part 'store_state.freezed.dart';

part 'store_state.g.dart';

@freezed
class StoreState with _$StoreState {
  factory StoreState({
    @Default([]) List<Store> storeList,
    @Default(false) bool isLoading,
  }) = _StoreState;

  factory StoreState.fromJson(Map<String, dynamic> json) => _$StoreStateFromJson(json);
}