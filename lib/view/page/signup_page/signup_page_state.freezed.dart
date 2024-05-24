// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignupPageState _$SignupPageStateFromJson(Map<String, dynamic> json) {
  return _SignupPageState.fromJson(json);
}

/// @nodoc
mixin _$SignupPageState {
  bool get showSnackbarPadding => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignupPageStateCopyWith<SignupPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupPageStateCopyWith<$Res> {
  factory $SignupPageStateCopyWith(
          SignupPageState value, $Res Function(SignupPageState) then) =
      _$SignupPageStateCopyWithImpl<$Res, SignupPageState>;
  @useResult
  $Res call({bool showSnackbarPadding});
}

/// @nodoc
class _$SignupPageStateCopyWithImpl<$Res, $Val extends SignupPageState>
    implements $SignupPageStateCopyWith<$Res> {
  _$SignupPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showSnackbarPadding = null,
  }) {
    return _then(_value.copyWith(
      showSnackbarPadding: null == showSnackbarPadding
          ? _value.showSnackbarPadding
          : showSnackbarPadding // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupPageStateImplCopyWith<$Res>
    implements $SignupPageStateCopyWith<$Res> {
  factory _$$SignupPageStateImplCopyWith(_$SignupPageStateImpl value,
          $Res Function(_$SignupPageStateImpl) then) =
      __$$SignupPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showSnackbarPadding});
}

/// @nodoc
class __$$SignupPageStateImplCopyWithImpl<$Res>
    extends _$SignupPageStateCopyWithImpl<$Res, _$SignupPageStateImpl>
    implements _$$SignupPageStateImplCopyWith<$Res> {
  __$$SignupPageStateImplCopyWithImpl(
      _$SignupPageStateImpl _value, $Res Function(_$SignupPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showSnackbarPadding = null,
  }) {
    return _then(_$SignupPageStateImpl(
      showSnackbarPadding: null == showSnackbarPadding
          ? _value.showSnackbarPadding
          : showSnackbarPadding // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignupPageStateImpl implements _SignupPageState {
  const _$SignupPageStateImpl({this.showSnackbarPadding = false});

  factory _$SignupPageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignupPageStateImplFromJson(json);

  @override
  @JsonKey()
  final bool showSnackbarPadding;

  @override
  String toString() {
    return 'SignupPageState(showSnackbarPadding: $showSnackbarPadding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupPageStateImpl &&
            (identical(other.showSnackbarPadding, showSnackbarPadding) ||
                other.showSnackbarPadding == showSnackbarPadding));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, showSnackbarPadding);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupPageStateImplCopyWith<_$SignupPageStateImpl> get copyWith =>
      __$$SignupPageStateImplCopyWithImpl<_$SignupPageStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignupPageStateImplToJson(
      this,
    );
  }
}

abstract class _SignupPageState implements SignupPageState {
  const factory _SignupPageState({final bool showSnackbarPadding}) =
      _$SignupPageStateImpl;

  factory _SignupPageState.fromJson(Map<String, dynamic> json) =
      _$SignupPageStateImpl.fromJson;

  @override
  bool get showSnackbarPadding;
  @override
  @JsonKey(ignore: true)
  _$$SignupPageStateImplCopyWith<_$SignupPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
