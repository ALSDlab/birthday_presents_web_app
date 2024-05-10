// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShoppingCartState _$ShoppingCartStateFromJson(Map<String, dynamic> json) {
  return _ShoppingCartState.fromJson(json);
}

/// @nodoc
mixin _$ShoppingCartState {
  List<ShoppingProductForCart> get cartList =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShoppingCartStateCopyWith<ShoppingCartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingCartStateCopyWith<$Res> {
  factory $ShoppingCartStateCopyWith(
          ShoppingCartState value, $Res Function(ShoppingCartState) then) =
      _$ShoppingCartStateCopyWithImpl<$Res, ShoppingCartState>;
  @useResult
  $Res call({List<ShoppingProductForCart> cartList, bool isLoading});
}

/// @nodoc
class _$ShoppingCartStateCopyWithImpl<$Res, $Val extends ShoppingCartState>
    implements $ShoppingCartStateCopyWith<$Res> {
  _$ShoppingCartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartList = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      cartList: null == cartList
          ? _value.cartList
          : cartList // ignore: cast_nullable_to_non_nullable
              as List<ShoppingProductForCart>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingCartStateImplCopyWith<$Res>
    implements $ShoppingCartStateCopyWith<$Res> {
  factory _$$ShoppingCartStateImplCopyWith(_$ShoppingCartStateImpl value,
          $Res Function(_$ShoppingCartStateImpl) then) =
      __$$ShoppingCartStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ShoppingProductForCart> cartList, bool isLoading});
}

/// @nodoc
class __$$ShoppingCartStateImplCopyWithImpl<$Res>
    extends _$ShoppingCartStateCopyWithImpl<$Res, _$ShoppingCartStateImpl>
    implements _$$ShoppingCartStateImplCopyWith<$Res> {
  __$$ShoppingCartStateImplCopyWithImpl(_$ShoppingCartStateImpl _value,
      $Res Function(_$ShoppingCartStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartList = null,
    Object? isLoading = null,
  }) {
    return _then(_$ShoppingCartStateImpl(
      cartList: null == cartList
          ? _value._cartList
          : cartList // ignore: cast_nullable_to_non_nullable
              as List<ShoppingProductForCart>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingCartStateImpl
    with DiagnosticableTreeMixin
    implements _ShoppingCartState {
  const _$ShoppingCartStateImpl(
      {final List<ShoppingProductForCart> cartList = const [],
      this.isLoading = false})
      : _cartList = cartList;

  factory _$ShoppingCartStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingCartStateImplFromJson(json);

  final List<ShoppingProductForCart> _cartList;
  @override
  @JsonKey()
  List<ShoppingProductForCart> get cartList {
    if (_cartList is EqualUnmodifiableListView) return _cartList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cartList);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ShoppingCartState(cartList: $cartList, isLoading: $isLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ShoppingCartState'))
      ..add(DiagnosticsProperty('cartList', cartList))
      ..add(DiagnosticsProperty('isLoading', isLoading));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingCartStateImpl &&
            const DeepCollectionEquality().equals(other._cartList, _cartList) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cartList), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingCartStateImplCopyWith<_$ShoppingCartStateImpl> get copyWith =>
      __$$ShoppingCartStateImplCopyWithImpl<_$ShoppingCartStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingCartStateImplToJson(
      this,
    );
  }
}

abstract class _ShoppingCartState implements ShoppingCartState {
  const factory _ShoppingCartState(
      {final List<ShoppingProductForCart> cartList,
      final bool isLoading}) = _$ShoppingCartStateImpl;

  factory _ShoppingCartState.fromJson(Map<String, dynamic> json) =
      _$ShoppingCartStateImpl.fromJson;

  @override
  List<ShoppingProductForCart> get cartList;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$ShoppingCartStateImplCopyWith<_$ShoppingCartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
