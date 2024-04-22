// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoreState _$StoreStateFromJson(Map<String, dynamic> json) {
  return _StoreState.fromJson(json);
}

/// @nodoc
mixin _$StoreState {
  List<Store> get storeList => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreStateCopyWith<StoreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreStateCopyWith<$Res> {
  factory $StoreStateCopyWith(
          StoreState value, $Res Function(StoreState) then) =
      _$StoreStateCopyWithImpl<$Res, StoreState>;
  @useResult
  $Res call({List<Store> storeList, bool isLoading});
}

/// @nodoc
class _$StoreStateCopyWithImpl<$Res, $Val extends StoreState>
    implements $StoreStateCopyWith<$Res> {
  _$StoreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeList = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      storeList: null == storeList
          ? _value.storeList
          : storeList // ignore: cast_nullable_to_non_nullable
              as List<Store>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoreStateImplCopyWith<$Res>
    implements $StoreStateCopyWith<$Res> {
  factory _$$StoreStateImplCopyWith(
          _$StoreStateImpl value, $Res Function(_$StoreStateImpl) then) =
      __$$StoreStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Store> storeList, bool isLoading});
}

/// @nodoc
class __$$StoreStateImplCopyWithImpl<$Res>
    extends _$StoreStateCopyWithImpl<$Res, _$StoreStateImpl>
    implements _$$StoreStateImplCopyWith<$Res> {
  __$$StoreStateImplCopyWithImpl(
      _$StoreStateImpl _value, $Res Function(_$StoreStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeList = null,
    Object? isLoading = null,
  }) {
    return _then(_$StoreStateImpl(
      storeList: null == storeList
          ? _value._storeList
          : storeList // ignore: cast_nullable_to_non_nullable
              as List<Store>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreStateImpl implements _StoreState {
  _$StoreStateImpl(
      {final List<Store> storeList = const [], this.isLoading = false})
      : _storeList = storeList;

  factory _$StoreStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreStateImplFromJson(json);

  final List<Store> _storeList;
  @override
  @JsonKey()
  List<Store> get storeList {
    if (_storeList is EqualUnmodifiableListView) return _storeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storeList);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'StoreState(storeList: $storeList, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreStateImpl &&
            const DeepCollectionEquality()
                .equals(other._storeList, _storeList) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_storeList), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreStateImplCopyWith<_$StoreStateImpl> get copyWith =>
      __$$StoreStateImplCopyWithImpl<_$StoreStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreStateImplToJson(
      this,
    );
  }
}

abstract class _StoreState implements StoreState {
  factory _StoreState({final List<Store> storeList, final bool isLoading}) =
      _$StoreStateImpl;

  factory _StoreState.fromJson(Map<String, dynamic> json) =
      _$StoreStateImpl.fromJson;

  @override
  List<Store> get storeList;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$StoreStateImplCopyWith<_$StoreStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
