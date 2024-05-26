import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_page_state.freezed.dart';

part 'profile_page_state.g.dart';

@freezed
class ProfilePageState with _$ProfilePageState {
  const factory ProfilePageState({
    @Default(false) bool isLoading,
  }) = _ProfilePageState;

  factory ProfilePageState.fromJson(Map<String, dynamic> json) =>
      _$ProfilePageStateFromJson(json);
}
