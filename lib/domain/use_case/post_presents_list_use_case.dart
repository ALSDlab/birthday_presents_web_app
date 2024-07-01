import 'package:Birthday_Presents_List/data/core/result.dart';

import '../../data/dto/presents_list_dto.dart';
import '../../data/mapper/presents_list_mapper.dart';
import '../model/presents_list_model.dart';
import '../repository/presents_list_repository.dart';

class PostPresentsListUseCase {
  PostPresentsListUseCase({
    required PresentsListRepository presentsListRepository,
  }) : _presentsListRepository = presentsListRepository;

  final PresentsListRepository _presentsListRepository;

  Future<Result<void>> execute(
      {required String myListDocId, required PresentsListModel myList}) async {
    PresentsListDto listForPost = PresentsListMapper.toDTO(myList);
    final result = await _presentsListRepository.postFirebaseMyPresentsList(
        myListDocId, listForPost);

    return result.when(
      success: (data) => const Result.success(null),
      error: (message) => throw Exception(message),
    );
  }
}
