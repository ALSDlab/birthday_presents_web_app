import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';

part 'signup_state.g.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState({
    required String name,
    required String id,
    required String password,
    required int phone,
    required String address,
  }) = _SignupState;

  factory SignupState.fromJson(Map<String, Object?> json) => _$SignupStateFromJson(json);
}