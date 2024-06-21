// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchPageState _$SearchPageStateFromJson(Map<String, dynamic> json) {
  return _SearchPageState.fromJson(json);
}

/// @nodoc
mixin _$SearchPageState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get showSnackbarPadding => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get forBadgeList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchPageStateCopyWith<SearchPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPageStateCopyWith<$Res> {
  factory $SearchPageStateCopyWith(
          SearchPageState value, $Res Function(SearchPageState) then) =
      _$SearchPageStateCopyWithImpl<$Res, SearchPageState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool showSnackbarPadding,
      List<Map<String, dynamic>> forBadgeList});
}

/// @nodoc
class _$SearchPageStateCopyWithImpl<$Res, $Val extends SearchPageState>
    implements $SearchPageStateCopyWith<$Res> {
  _$SearchPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? showSnackbarPadding = null,
    Object? forBadgeList = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      showSnackbarPadding: null == showSnackbarPadding
          ? _value.showSnackbarPadding
          : showSnackbarPadding // ignore: cast_nullable_to_non_nullable
              as bool,
      forBadgeList: null == forBadgeList
          ? _value.forBadgeList
          : forBadgeList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchPageStateImplCopyWith<$Res>
    implements $SearchPageStateCopyWith<$Res> {
  factory _$$SearchPageStateImplCopyWith(_$SearchPageStateImpl value,
          $Res Function(_$SearchPageStateImpl) then) =
      __$$SearchPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool showSnackbarPadding,
      List<Map<String, dynamic>> forBadgeList});
}

/// @nodoc
class __$$SearchPageStateImplCopyWithImpl<$Res>
    extends _$SearchPageStateCopyWithImpl<$Res, _$SearchPageStateImpl>
    implements _$$SearchPageStateImplCopyWith<$Res> {
  __$$SearchPageStateImplCopyWithImpl(
      _$SearchPageStateImpl _value, $Res Function(_$SearchPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? showSnackbarPadding = null,
    Object? forBadgeList = null,
  }) {
    return _then(_$SearchPageStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      showSnackbarPadding: null == showSnackbarPadding
          ? _value.showSnackbarPadding
          : showSnackbarPadding // ignore: cast_nullable_to_non_nullable
              as bool,
      forBadgeList: null == forBadgeList
          ? _value._forBadgeList
          : forBadgeList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchPageStateImpl
    with DiagnosticableTreeMixin
    implements _SearchPageState {
  const _$SearchPageStateImpl(
      {this.isLoading = false,
      this.showSnackbarPadding = false,
      final List<Map<String, dynamic>> forBadgeList = const []})
      : _forBadgeList = forBadgeList;

  factory _$SearchPageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchPageStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool showSnackbarPadding;
  final List<Map<String, dynamic>> _forBadgeList;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get forBadgeList {
    if (_forBadgeList is EqualUnmodifiableListView) return _forBadgeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_forBadgeList);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchPageState(isLoading: $isLoading, showSnackbarPadding: $showSnackbarPadding, forBadgeList: $forBadgeList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchPageState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('showSnackbarPadding', showSnackbarPadding))
      ..add(DiagnosticsProperty('forBadgeList', forBadgeList));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchPageStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.showSnackbarPadding, showSnackbarPadding) ||
                other.showSnackbarPadding == showSnackbarPadding) &&
            const DeepCollectionEquality()
                .equals(other._forBadgeList, _forBadgeList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLoading, showSnackbarPadding,
      const DeepCollectionEquality().hash(_forBadgeList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchPageStateImplCopyWith<_$SearchPageStateImpl> get copyWith =>
      __$$SearchPageStateImplCopyWithImpl<_$SearchPageStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchPageStateImplToJson(
      this,
    );
  }
}

abstract class _SearchPageState implements SearchPageState {
  const factory _SearchPageState(
      {final bool isLoading,
      final bool showSnackbarPadding,
      final List<Map<String, dynamic>> forBadgeList}) = _$SearchPageStateImpl;

  factory _SearchPageState.fromJson(Map<String, dynamic> json) =
      _$SearchPageStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  bool get showSnackbarPadding;
  @override
  List<Map<String, dynamic>> get forBadgeList;
  @override
  @JsonKey(ignore: true)
  _$$SearchPageStateImplCopyWith<_$SearchPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
