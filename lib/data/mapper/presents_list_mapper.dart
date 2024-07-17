import '../../domain/model/presents_list_model.dart';
import '../dto/presents_list_dto.dart';

class PresentsListMapper {
  static PresentsListModel fromDTO(PresentsListDto dto) {
    return PresentsListModel(
      name: dto.name ?? '',
      birthYear: dto.birthYear ?? 0,
      createdDate: dto.createdDate ?? '',
      completed: dto.completed ?? false,
      links: dto.links ?? [],

    );
  }

  static PresentsListDto toDTO(PresentsListModel model) {
    return PresentsListDto(
      name: model.name,
      birthYear: model.birthYear,
      createdDate: model.createdDate,
        completed: model.completed,
      links: model.links.isNotEmpty
          ? model.links.map((item) => Map<String, dynamic>.from(item)).toList()
          : [],
    );
  }
}
