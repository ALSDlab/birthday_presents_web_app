import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'edit_user_info_state.freezed.dart';

part 'edit_user_info_state.g.dart';

@freezed
class EditUserInfoState with _$EditUserInfoState {
  const factory EditUserInfoState({

    @Default(false) bool showSnackbarPadding,
    @Default(false) bool isLoading,
    @Default(false) bool addressChange,
  }) = _EditUserInfoState;

  factory EditUserInfoState.fromJson(Map<String, dynamic> json) => _$EditUserInfoStateFromJson(json);
}