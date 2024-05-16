// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_history_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderHistoryPageState _$OrderHistoryPageStateFromJson(
    Map<String, dynamic> json) {
  return _OrderHistoryPageState.fromJson(json);
}

/// @nodoc
mixin _$OrderHistoryPageState {
  List<List<OrderModel>> get orderHistoryList =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isAscending => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderHistoryPageStateCopyWith<OrderHistoryPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderHistoryPageStateCopyWith<$Res> {
  factory $OrderHistoryPageStateCopyWith(OrderHistoryPageState value,
          $Res Function(OrderHistoryPageState) then) =
      _$OrderHistoryPageStateCopyWithImpl<$Res, OrderHistoryPageState>;
  @useResult
  $Res call(
      {List<List<OrderModel>> orderHistoryList,
      bool isLoading,
      bool isAscending});
}

/// @nodoc
class _$OrderHistoryPageStateCopyWithImpl<$Res,
        $Val extends OrderHistoryPageState>
    implements $OrderHistoryPageStateCopyWith<$Res> {
  _$OrderHistoryPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderHistoryList = null,
    Object? isLoading = null,
    Object? isAscending = null,
  }) {
    return _then(_value.copyWith(
      orderHistoryList: null == orderHistoryList
          ? _value.orderHistoryList
          : orderHistoryList // ignore: cast_nullable_to_non_nullable
              as List<List<OrderModel>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAscending: null == isAscending
          ? _value.isAscending
          : isAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderHistoryPageStateImplCopyWith<$Res>
    implements $OrderHistoryPageStateCopyWith<$Res> {
  factory _$$OrderHistoryPageStateImplCopyWith(
          _$OrderHistoryPageStateImpl value,
          $Res Function(_$OrderHistoryPageStateImpl) then) =
      __$$OrderHistoryPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<List<OrderModel>> orderHistoryList,
      bool isLoading,
      bool isAscending});
}

/// @nodoc
class __$$OrderHistoryPageStateImplCopyWithImpl<$Res>
    extends _$OrderHistoryPageStateCopyWithImpl<$Res,
        _$OrderHistoryPageStateImpl>
    implements _$$OrderHistoryPageStateImplCopyWith<$Res> {
  __$$OrderHistoryPageStateImplCopyWithImpl(_$OrderHistoryPageStateImpl _value,
      $Res Function(_$OrderHistoryPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderHistoryList = null,
    Object? isLoading = null,
    Object? isAscending = null,
  }) {
    return _then(_$OrderHistoryPageStateImpl(
      orderHistoryList: null == orderHistoryList
          ? _value._orderHistoryList
          : orderHistoryList // ignore: cast_nullable_to_non_nullable
              as List<List<OrderModel>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAscending: null == isAscending
          ? _value.isAscending
          : isAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderHistoryPageStateImpl implements _OrderHistoryPageState {
  const _$OrderHistoryPageStateImpl(
      {final List<List<OrderModel>> orderHistoryList = const [],
      this.isLoading = false,
      this.isAscending = true})
      : _orderHistoryList = orderHistoryList;

  factory _$OrderHistoryPageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderHistoryPageStateImplFromJson(json);

  final List<List<OrderModel>> _orderHistoryList;
  @override
  @JsonKey()
  List<List<OrderModel>> get orderHistoryList {
    if (_orderHistoryList is EqualUnmodifiableListView)
      return _orderHistoryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderHistoryList);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isAscending;

  @override
  String toString() {
    return 'OrderHistoryPageState(orderHistoryList: $orderHistoryList, isLoading: $isLoading, isAscending: $isAscending)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._orderHistoryList, _orderHistoryList) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isAscending, isAscending) ||
                other.isAscending == isAscending));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_orderHistoryList),
      isLoading,
      isAscending);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderHistoryPageStateImplCopyWith<_$OrderHistoryPageStateImpl>
      get copyWith => __$$OrderHistoryPageStateImplCopyWithImpl<
          _$OrderHistoryPageStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderHistoryPageStateImplToJson(
      this,
    );
  }
}

abstract class _OrderHistoryPageState implements OrderHistoryPageState {
  const factory _OrderHistoryPageState(
      {final List<List<OrderModel>> orderHistoryList,
      final bool isLoading,
      final bool isAscending}) = _$OrderHistoryPageStateImpl;

  factory _OrderHistoryPageState.fromJson(Map<String, dynamic> json) =
      _$OrderHistoryPageStateImpl.fromJson;

  @override
  List<List<OrderModel>> get orderHistoryList;
  @override
  bool get isLoading;
  @override
  bool get isAscending;
  @override
  @JsonKey(ignore: true)
  _$$OrderHistoryPageStateImplCopyWith<_$OrderHistoryPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
