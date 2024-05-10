// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fill_order_form_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FillOrderFormPageState _$FillOrderFormPageStateFromJson(
    Map<String, dynamic> json) {
  return _FillOrderFormPageState.fromJson(json);
}

/// @nodoc
mixin _$FillOrderFormPageState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get addressChange => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FillOrderFormPageStateCopyWith<FillOrderFormPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FillOrderFormPageStateCopyWith<$Res> {
  factory $FillOrderFormPageStateCopyWith(FillOrderFormPageState value,
          $Res Function(FillOrderFormPageState) then) =
      _$FillOrderFormPageStateCopyWithImpl<$Res, FillOrderFormPageState>;
  @useResult
  $Res call({bool isLoading, bool addressChange});
}

/// @nodoc
class _$FillOrderFormPageStateCopyWithImpl<$Res,
        $Val extends FillOrderFormPageState>
    implements $FillOrderFormPageStateCopyWith<$Res> {
  _$FillOrderFormPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addressChange = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      addressChange: null == addressChange
          ? _value.addressChange
          : addressChange // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FillOrderFormPageStateImplCopyWith<$Res>
    implements $FillOrderFormPageStateCopyWith<$Res> {
  factory _$$FillOrderFormPageStateImplCopyWith(
          _$FillOrderFormPageStateImpl value,
          $Res Function(_$FillOrderFormPageStateImpl) then) =
      __$$FillOrderFormPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool addressChange});
}

/// @nodoc
class __$$FillOrderFormPageStateImplCopyWithImpl<$Res>
    extends _$FillOrderFormPageStateCopyWithImpl<$Res,
        _$FillOrderFormPageStateImpl>
    implements _$$FillOrderFormPageStateImplCopyWith<$Res> {
  __$$FillOrderFormPageStateImplCopyWithImpl(
      _$FillOrderFormPageStateImpl _value,
      $Res Function(_$FillOrderFormPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addressChange = null,
  }) {
    return _then(_$FillOrderFormPageStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      addressChange: null == addressChange
          ? _value.addressChange
          : addressChange // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FillOrderFormPageStateImpl implements _FillOrderFormPageState {
  const _$FillOrderFormPageStateImpl(
      {this.isLoading = false, this.addressChange = false});

  factory _$FillOrderFormPageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FillOrderFormPageStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool addressChange;

  @override
  String toString() {
    return 'FillOrderFormPageState(isLoading: $isLoading, addressChange: $addressChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FillOrderFormPageStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.addressChange, addressChange) ||
                other.addressChange == addressChange));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLoading, addressChange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FillOrderFormPageStateImplCopyWith<_$FillOrderFormPageStateImpl>
      get copyWith => __$$FillOrderFormPageStateImplCopyWithImpl<
          _$FillOrderFormPageStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FillOrderFormPageStateImplToJson(
      this,
    );
  }
}

abstract class _FillOrderFormPageState implements FillOrderFormPageState {
  const factory _FillOrderFormPageState(
      {final bool isLoading,
      final bool addressChange}) = _$FillOrderFormPageStateImpl;

  factory _FillOrderFormPageState.fromJson(Map<String, dynamic> json) =
      _$FillOrderFormPageStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  bool get addressChange;
  @override
  @JsonKey(ignore: true)
  _$$FillOrderFormPageStateImplCopyWith<_$FillOrderFormPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
