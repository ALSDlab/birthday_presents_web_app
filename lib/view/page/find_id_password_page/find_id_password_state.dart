import 'package:freezed_annotation/freezed_annotation.dart';

part 'find_id_password_state.freezed.dart';
part 'find_id_password_state.g.dart';

@freezed
class FindIdPasswordState with _$FindIdPasswordState {
  const factory FindIdPasswordState({
    @Default(false) bool showSnackbarPadding,
    @Default(false) bool isLoading,
  }) = _FindIdPasswordState;

  factory FindIdPasswordState.fromJson(Map<String, dynamic> json) =>
      _$FindIdPasswordStateFromJson(json);
}
