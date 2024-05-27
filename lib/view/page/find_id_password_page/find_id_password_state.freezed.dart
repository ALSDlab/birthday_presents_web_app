// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'find_id_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FindIdPasswordState _$FindIdPasswordStateFromJson(Map<String, dynamic> json) {
  return _FindIdPasswordState.fromJson(json);
}

/// @nodoc
mixin _$FindIdPasswordState {
  bool get showSnackbarPadding => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FindIdPasswordStateCopyWith<FindIdPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FindIdPasswordStateCopyWith<$Res> {
  factory $FindIdPasswordStateCopyWith(
          FindIdPasswordState value, $Res Function(FindIdPasswordState) then) =
      _$FindIdPasswordStateCopyWithImpl<$Res, FindIdPasswordState>;
  @useResult
  $Res call({bool showSnackbarPadding, bool isLoading});
}

/// @nodoc
class _$FindIdPasswordStateCopyWithImpl<$Res, $Val extends FindIdPasswordState>
    implements $FindIdPasswordStateCopyWith<$Res> {
  _$FindIdPasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showSnackbarPadding = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      showSnackbarPadding: null == showSnackbarPadding
          ? _value.showSnackbarPadding
          : showSnackbarPadding // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FindIdPasswordStateImplCopyWith<$Res>
    implements $FindIdPasswordStateCopyWith<$Res> {
  factory _$$FindIdPasswordStateImplCopyWith(_$FindIdPasswordStateImpl value,
          $Res Function(_$FindIdPasswordStateImpl) then) =
      __$$FindIdPasswordStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showSnackbarPadding, bool isLoading});
}

/// @nodoc
class __$$FindIdPasswordStateImplCopyWithImpl<$Res>
    extends _$FindIdPasswordStateCopyWithImpl<$Res, _$FindIdPasswordStateImpl>
    implements _$$FindIdPasswordStateImplCopyWith<$Res> {
  __$$FindIdPasswordStateImplCopyWithImpl(_$FindIdPasswordStateImpl _value,
      $Res Function(_$FindIdPasswordStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showSnackbarPadding = null,
    Object? isLoading = null,
  }) {
    return _then(_$FindIdPasswordStateImpl(
      showSnackbarPadding: null == showSnackbarPadding
          ? _value.showSnackbarPadding
          : showSnackbarPadding // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FindIdPasswordStateImpl implements _FindIdPasswordState {
  const _$FindIdPasswordStateImpl(
      {this.showSnackbarPadding = false, this.isLoading = false});

  factory _$FindIdPasswordStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FindIdPasswordStateImplFromJson(json);

  @override
  @JsonKey()
  final bool showSnackbarPadding;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'FindIdPasswordState(showSnackbarPadding: $showSnackbarPadding, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FindIdPasswordStateImpl &&
            (identical(other.showSnackbarPadding, showSnackbarPadding) ||
                other.showSnackbarPadding == showSnackbarPadding) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, showSnackbarPadding, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FindIdPasswordStateImplCopyWith<_$FindIdPasswordStateImpl> get copyWith =>
      __$$FindIdPasswordStateImplCopyWithImpl<_$FindIdPasswordStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FindIdPasswordStateImplToJson(
      this,
    );
  }
}

abstract class _FindIdPasswordState implements FindIdPasswordState {
  const factory _FindIdPasswordState(
      {final bool showSnackbarPadding,
      final bool isLoading}) = _$FindIdPasswordStateImpl;

  factory _FindIdPasswordState.fromJson(Map<String, dynamic> json) =
      _$FindIdPasswordStateImpl.fromJson;

  @override
  bool get showSnackbarPadding;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$FindIdPasswordStateImplCopyWith<_$FindIdPasswordStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
