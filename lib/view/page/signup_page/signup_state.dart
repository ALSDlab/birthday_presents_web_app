import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';

part 'signup_state.g.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState({
    @Default('') String name,
    @Default('') String id,
    @Default('') String password,
    @Default(0) int phone,
    required String address,
    required String zoneCode,
  }) = _SignupState;

  factory SignupState.fromJson(Map<String, Object?> json) => _$SignupStateFromJson(json);
}