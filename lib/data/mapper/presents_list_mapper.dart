import 'package:myk_market_app/data/dto/presents_list_dto.dart';

import '../../domain/model/presents_list_model.dart';

class PresentsListMapper {
  static PresentsListModel fromDTO(PresentsListDto dto) {
    return PresentsListModel(
      name: dto.name ?? '',
      birthYear: dto.birthYear ?? 0,
      createdDate: dto.createdDate ?? '',
      links: dto.links ?? [],
    );
  }

  static PresentsListDto toDTO(PresentsListModel model) {
    return PresentsListDto(
      name: model.name,
      birthYear: model.birthYear,
      createdDate: model.createdDate,
      links: model.links.isNotEmpty
          ? model.links.map((item) => Map<String, dynamic>.from(item)).toList()
          : [],
    );
  }
}
