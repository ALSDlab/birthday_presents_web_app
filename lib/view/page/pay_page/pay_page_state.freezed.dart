// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pay_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayPageState _$PayPageStateFromJson(Map<String, dynamic> json) {
  return _PayPageState.fromJson(json);
}

/// @nodoc
mixin _$PayPageState {
  List<OrderModel> get orderItems => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayPageStateCopyWith<PayPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayPageStateCopyWith<$Res> {
  factory $PayPageStateCopyWith(
          PayPageState value, $Res Function(PayPageState) then) =
      _$PayPageStateCopyWithImpl<$Res, PayPageState>;
  @useResult
  $Res call({List<OrderModel> orderItems, bool isLoading});
}

/// @nodoc
class _$PayPageStateCopyWithImpl<$Res, $Val extends PayPageState>
    implements $PayPageStateCopyWith<$Res> {
  _$PayPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderItems = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      orderItems: null == orderItems
          ? _value.orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayPageStateImplCopyWith<$Res>
    implements $PayPageStateCopyWith<$Res> {
  factory _$$PayPageStateImplCopyWith(
          _$PayPageStateImpl value, $Res Function(_$PayPageStateImpl) then) =
      __$$PayPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrderModel> orderItems, bool isLoading});
}

/// @nodoc
class __$$PayPageStateImplCopyWithImpl<$Res>
    extends _$PayPageStateCopyWithImpl<$Res, _$PayPageStateImpl>
    implements _$$PayPageStateImplCopyWith<$Res> {
  __$$PayPageStateImplCopyWithImpl(
      _$PayPageStateImpl _value, $Res Function(_$PayPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderItems = null,
    Object? isLoading = null,
  }) {
    return _then(_$PayPageStateImpl(
      orderItems: null == orderItems
          ? _value._orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayPageStateImpl implements _PayPageState {
  const _$PayPageStateImpl(
      {final List<OrderModel> orderItems = const [], this.isLoading = false})
      : _orderItems = orderItems;

  factory _$PayPageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayPageStateImplFromJson(json);

  final List<OrderModel> _orderItems;
  @override
  @JsonKey()
  List<OrderModel> get orderItems {
    if (_orderItems is EqualUnmodifiableListView) return _orderItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItems);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'PayPageState(orderItems: $orderItems, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._orderItems, _orderItems) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_orderItems), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayPageStateImplCopyWith<_$PayPageStateImpl> get copyWith =>
      __$$PayPageStateImplCopyWithImpl<_$PayPageStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayPageStateImplToJson(
      this,
    );
  }
}

abstract class _PayPageState implements PayPageState {
  const factory _PayPageState(
      {final List<OrderModel> orderItems,
      final bool isLoading}) = _$PayPageStateImpl;

  factory _PayPageState.fromJson(Map<String, dynamic> json) =
      _$PayPageStateImpl.fromJson;

  @override
  List<OrderModel> get orderItems;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$PayPageStateImplCopyWith<_$PayPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
