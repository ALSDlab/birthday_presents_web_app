// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presents_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PresentsListState _$PresentsListStateFromJson(Map<String, dynamic> json) {
  return _PresentsListState.fromJson(json);
}

/// @nodoc
mixin _$PresentsListState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get showSnackbarPadding => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get linksList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PresentsListStateCopyWith<PresentsListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresentsListStateCopyWith<$Res> {
  factory $PresentsListStateCopyWith(
          PresentsListState value, $Res Function(PresentsListState) then) =
      _$PresentsListStateCopyWithImpl<$Res, PresentsListState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool showSnackbarPadding,
      List<Map<String, dynamic>> linksList});
}

/// @nodoc
class _$PresentsListStateCopyWithImpl<$Res, $Val extends PresentsListState>
    implements $PresentsListStateCopyWith<$Res> {
  _$PresentsListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? showSnackbarPadding = null,
    Object? linksList = null,
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
      linksList: null == linksList
          ? _value.linksList
          : linksList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PresentsListStateImplCopyWith<$Res>
    implements $PresentsListStateCopyWith<$Res> {
  factory _$$PresentsListStateImplCopyWith(_$PresentsListStateImpl value,
          $Res Function(_$PresentsListStateImpl) then) =
      __$$PresentsListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool showSnackbarPadding,
      List<Map<String, dynamic>> linksList});
}

/// @nodoc
class __$$PresentsListStateImplCopyWithImpl<$Res>
    extends _$PresentsListStateCopyWithImpl<$Res, _$PresentsListStateImpl>
    implements _$$PresentsListStateImplCopyWith<$Res> {
  __$$PresentsListStateImplCopyWithImpl(_$PresentsListStateImpl _value,
      $Res Function(_$PresentsListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? showSnackbarPadding = null,
    Object? linksList = null,
  }) {
    return _then(_$PresentsListStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      showSnackbarPadding: null == showSnackbarPadding
          ? _value.showSnackbarPadding
          : showSnackbarPadding // ignore: cast_nullable_to_non_nullable
              as bool,
      linksList: null == linksList
          ? _value._linksList
          : linksList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentsListStateImpl
    with DiagnosticableTreeMixin
    implements _PresentsListState {
  const _$PresentsListStateImpl(
      {this.isLoading = false,
      this.showSnackbarPadding = false,
      final List<Map<String, dynamic>> linksList = const []})
      : _linksList = linksList;

  factory _$PresentsListStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresentsListStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool showSnackbarPadding;
  final List<Map<String, dynamic>> _linksList;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get linksList {
    if (_linksList is EqualUnmodifiableListView) return _linksList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linksList);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PresentsListState(isLoading: $isLoading, showSnackbarPadding: $showSnackbarPadding, linksList: $linksList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PresentsListState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('showSnackbarPadding', showSnackbarPadding))
      ..add(DiagnosticsProperty('linksList', linksList));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentsListStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.showSnackbarPadding, showSnackbarPadding) ||
                other.showSnackbarPadding == showSnackbarPadding) &&
            const DeepCollectionEquality()
                .equals(other._linksList, _linksList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLoading, showSnackbarPadding,
      const DeepCollectionEquality().hash(_linksList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentsListStateImplCopyWith<_$PresentsListStateImpl> get copyWith =>
      __$$PresentsListStateImplCopyWithImpl<_$PresentsListStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentsListStateImplToJson(
      this,
    );
  }
}

abstract class _PresentsListState implements PresentsListState {
  const factory _PresentsListState(
      {final bool isLoading,
      final bool showSnackbarPadding,
      final List<Map<String, dynamic>> linksList}) = _$PresentsListStateImpl;

  factory _PresentsListState.fromJson(Map<String, dynamic> json) =
      _$PresentsListStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  bool get showSnackbarPadding;
  @override
  List<Map<String, dynamic>> get linksList;
  @override
  @JsonKey(ignore: true)
  _$$PresentsListStateImplCopyWith<_$PresentsListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
