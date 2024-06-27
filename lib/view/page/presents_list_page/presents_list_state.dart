import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'presents_list_state.freezed.dart';

part 'presents_list_state.g.dart';

@freezed
class PresentsListState with _$PresentsListState {
  const factory PresentsListState({
    @Default(false) bool isLoading,
    @Default(false) bool showSnackbarPadding,
    @Default('') String loadedDocId,
    @Default([]) List<Map<String, dynamic>> linksList,

  }) = _PresentsListState;

  factory PresentsListState.fromJson(Map<String, Object?> json) =>
      _$PresentsListStateFromJson(json);
}
