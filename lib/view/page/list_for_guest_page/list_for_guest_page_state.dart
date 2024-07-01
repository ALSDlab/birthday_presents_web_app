import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'list_for_guest_page_state.freezed.dart';

part 'list_for_guest_page_state.g.dart';

@freezed
class ListForGuestPageState with _$ListForGuestPageState {
  const factory ListForGuestPageState({
    @Default(false) bool isLoading,
    @Default(false) bool showSnackbarPadding,
    @Default(false) bool isCompleted,
    @Default('') String getDocId,
    @Default('') String getName,
    @Default(0) int getBirthYear,
    @Default([]) List<Map<String, dynamic>> linksList,


  }) = _ListForGuestPageState;

  factory ListForGuestPageState.fromJson(Map<String, dynamic> json) => _$ListForGuestPageStateFromJson(json);
}