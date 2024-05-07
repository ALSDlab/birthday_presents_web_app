import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../data/model/shopping_cart_model.dart';


part 'scaffold_with_nav_bar_state.freezed.dart';

part 'scaffold_with_nav_bar_state.g.dart';

@freezed
class ScaffoldWithNavBarState with _$ScaffoldWithNavBarState {
  const factory ScaffoldWithNavBarState({
    @Default([]) List<ShoppingProductForCart> forBadgeList,

  }) = _ScaffoldWithNavBarState;

  factory ScaffoldWithNavBarState.fromJson(Map<String, dynamic> json) => _$ScaffoldWithNavBarStateFromJson(json);
}