import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'search_page_state.freezed.dart';

part 'search_page_state.g.dart';

@freezed
class SearchPageState with _$SearchPageState {
  const factory SearchPageState({
    @Default(false) bool isLoading,
    @Default(false) bool showSnackbarPadding,
    @Default([]) List<Map<String, dynamic>> forBadgeList,
  }) = _SearchPageState;

  factory SearchPageState.fromJson(Map<String, Object?> json) => _$SearchPageStateFromJson(json);
}