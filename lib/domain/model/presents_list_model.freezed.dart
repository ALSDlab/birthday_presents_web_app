// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presents_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PresentsListModel _$PresentsListModelFromJson(Map<String, dynamic> json) {
  return _PresentsListModel.fromJson(json);
}

/// @nodoc
mixin _$PresentsListModel {
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'birthYear')
  int get birthYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdDate')
  String get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed')
  bool get completed => throw _privateConstructorUsedError;
  @JsonKey(name: 'links')
  List<Map<String, dynamic>> get links => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PresentsListModelCopyWith<PresentsListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresentsListModelCopyWith<$Res> {
  factory $PresentsListModelCopyWith(
          PresentsListModel value, $Res Function(PresentsListModel) then) =
      _$PresentsListModelCopyWithImpl<$Res, PresentsListModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'birthYear') int birthYear,
      @JsonKey(name: 'createdDate') String createdDate,
      @JsonKey(name: 'completed') bool completed,
      @JsonKey(name: 'links') List<Map<String, dynamic>> links});
}

/// @nodoc
class _$PresentsListModelCopyWithImpl<$Res, $Val extends PresentsListModel>
    implements $PresentsListModelCopyWith<$Res> {
  _$PresentsListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? birthYear = null,
    Object? createdDate = null,
    Object? completed = null,
    Object? links = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthYear: null == birthYear
          ? _value.birthYear
          : birthYear // ignore: cast_nullable_to_non_nullable
              as int,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      links: null == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PresentsListModelImplCopyWith<$Res>
    implements $PresentsListModelCopyWith<$Res> {
  factory _$$PresentsListModelImplCopyWith(_$PresentsListModelImpl value,
          $Res Function(_$PresentsListModelImpl) then) =
      __$$PresentsListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'birthYear') int birthYear,
      @JsonKey(name: 'createdDate') String createdDate,
      @JsonKey(name: 'completed') bool completed,
      @JsonKey(name: 'links') List<Map<String, dynamic>> links});
}

/// @nodoc
class __$$PresentsListModelImplCopyWithImpl<$Res>
    extends _$PresentsListModelCopyWithImpl<$Res, _$PresentsListModelImpl>
    implements _$$PresentsListModelImplCopyWith<$Res> {
  __$$PresentsListModelImplCopyWithImpl(_$PresentsListModelImpl _value,
      $Res Function(_$PresentsListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? birthYear = null,
    Object? createdDate = null,
    Object? completed = null,
    Object? links = null,
  }) {
    return _then(_$PresentsListModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthYear: null == birthYear
          ? _value.birthYear
          : birthYear // ignore: cast_nullable_to_non_nullable
              as int,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentsListModelImpl implements _PresentsListModel {
  const _$PresentsListModelImpl(
      {@JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'birthYear') required this.birthYear,
      @JsonKey(name: 'createdDate') required this.createdDate,
      @JsonKey(name: 'completed') required this.completed,
      @JsonKey(name: 'links') required final List<Map<String, dynamic>> links})
      : _links = links;

  factory _$PresentsListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresentsListModelImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'birthYear')
  final int birthYear;
  @override
  @JsonKey(name: 'createdDate')
  final String createdDate;
  @override
  @JsonKey(name: 'completed')
  final bool completed;
  final List<Map<String, dynamic>> _links;
  @override
  @JsonKey(name: 'links')
  List<Map<String, dynamic>> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  @override
  String toString() {
    return 'PresentsListModel(name: $name, birthYear: $birthYear, createdDate: $createdDate, completed: $completed, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentsListModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthYear, birthYear) ||
                other.birthYear == birthYear) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            const DeepCollectionEquality().equals(other._links, _links));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, birthYear, createdDate,
      completed, const DeepCollectionEquality().hash(_links));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentsListModelImplCopyWith<_$PresentsListModelImpl> get copyWith =>
      __$$PresentsListModelImplCopyWithImpl<_$PresentsListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentsListModelImplToJson(
      this,
    );
  }
}

abstract class _PresentsListModel implements PresentsListModel {
  const factory _PresentsListModel(
          {@JsonKey(name: 'name') required final String name,
          @JsonKey(name: 'birthYear') required final int birthYear,
          @JsonKey(name: 'createdDate') required final String createdDate,
          @JsonKey(name: 'completed') required final bool completed,
          @JsonKey(name: 'links')
          required final List<Map<String, dynamic>> links}) =
      _$PresentsListModelImpl;

  factory _PresentsListModel.fromJson(Map<String, dynamic> json) =
      _$PresentsListModelImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'birthYear')
  int get birthYear;
  @override
  @JsonKey(name: 'createdDate')
  String get createdDate;
  @override
  @JsonKey(name: 'completed')
  bool get completed;
  @override
  @JsonKey(name: 'links')
  List<Map<String, dynamic>> get links;
  @override
  @JsonKey(ignore: true)
  _$$PresentsListModelImplCopyWith<_$PresentsListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
