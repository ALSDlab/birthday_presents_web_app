import 'package:freezed_annotation/freezed_annotation.dart';

part 'fill_order_form_page_state.freezed.dart';
part 'fill_order_form_page_state.g.dart';

@freezed
class FillOrderFormPageState with _$FillOrderFormPageState {
  const factory FillOrderFormPageState({
    @Default(false) bool isLoading,
  }) = _FillOrderFormPageState;

  factory FillOrderFormPageState.fromJson(Map<String, dynamic> json) =>
      _$FillOrderFormPageStateFromJson(json);
}