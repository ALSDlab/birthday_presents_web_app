// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginPageState _$LoginPageStateFromJson(Map<String, dynamic> json) {
  return _LoginPageState.fromJson(json);
}

/// @nodoc
mixin _$LoginPageState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<OrderModel> get orderItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginPageStateCopyWith<LoginPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginPageStateCopyWith<$Res> {
  factory $LoginPageStateCopyWith(
          LoginPageState value, $Res Function(LoginPageState) then) =
      _$LoginPageStateCopyWithImpl<$Res, LoginPageState>;
  @useResult
  $Res call({bool isLoading, List<OrderModel> orderItems});
}

/// @nodoc
class _$LoginPageStateCopyWithImpl<$Res, $Val extends LoginPageState>
    implements $LoginPageStateCopyWith<$Res> {
  _$LoginPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? orderItems = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      orderItems: null == orderItems
          ? _value.orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginPageStateImplCopyWith<$Res>
    implements $LoginPageStateCopyWith<$Res> {
  factory _$$LoginPageStateImplCopyWith(_$LoginPageStateImpl value,
          $Res Function(_$LoginPageStateImpl) then) =
      __$$LoginPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<OrderModel> orderItems});
}

/// @nodoc
class __$$LoginPageStateImplCopyWithImpl<$Res>
    extends _$LoginPageStateCopyWithImpl<$Res, _$LoginPageStateImpl>
    implements _$$LoginPageStateImplCopyWith<$Res> {
  __$$LoginPageStateImplCopyWithImpl(
      _$LoginPageStateImpl _value, $Res Function(_$LoginPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? orderItems = null,
  }) {
    return _then(_$LoginPageStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      orderItems: null == orderItems
          ? _value._orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginPageStateImpl implements _LoginPageState {
  const _$LoginPageStateImpl(
      {this.isLoading = false, final List<OrderModel> orderItems = const []})
      : _orderItems = orderItems;

  factory _$LoginPageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginPageStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  final List<OrderModel> _orderItems;
  @override
  @JsonKey()
  List<OrderModel> get orderItems {
    if (_orderItems is EqualUnmodifiableListView) return _orderItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItems);
  }

  @override
  String toString() {
    return 'LoginPageState(isLoading: $isLoading, orderItems: $orderItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPageStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._orderItems, _orderItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_orderItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginPageStateImplCopyWith<_$LoginPageStateImpl> get copyWith =>
      __$$LoginPageStateImplCopyWithImpl<_$LoginPageStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginPageStateImplToJson(
      this,
    );
  }
}

abstract class _LoginPageState implements LoginPageState {
  const factory _LoginPageState(
      {final bool isLoading,
      final List<OrderModel> orderItems}) = _$LoginPageStateImpl;

  factory _LoginPageState.fromJson(Map<String, dynamic> json) =
      _$LoginPageStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  List<OrderModel> get orderItems;
  @override
  @JsonKey(ignore: true)
  _$$LoginPageStateImplCopyWith<_$LoginPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
