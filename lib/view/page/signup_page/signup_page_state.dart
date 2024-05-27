import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_page_state.freezed.dart';
part 'signup_page_state.g.dart';

@freezed
class SignupPageState with _$SignupPageState {
  const factory SignupPageState({
    @Default(false) bool showSnackbarPadding,
    @Default(false) bool isLoading,
    @Default([]) List<String> existingEmails,
  }) = _SignupPageState;

  factory SignupPageState.fromJson(Map<String, dynamic> json) =>
      _$SignupPageStateFromJson(json);
}
