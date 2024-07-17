import 'package:freezed_annotation/freezed_annotation.dart';

part 'presents_list_model.freezed.dart';
part 'presents_list_model.g.dart';

@freezed
class PresentsListModel with _$PresentsListModel {
  const factory PresentsListModel({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'birthYear') required int birthYear,
    @JsonKey(name: 'createdDate') required String createdDate,
    @JsonKey(name: 'completed') required bool completed,
    @JsonKey(name: 'links') required List<Map<String, dynamic>> links,
  }) = _PresentsListModel;

  factory PresentsListModel.fromJson(Map<String, dynamic> json) =>
      _$PresentsListModelFromJson(json);
}
