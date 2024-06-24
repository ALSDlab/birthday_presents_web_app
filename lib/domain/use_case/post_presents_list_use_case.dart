import '../../data/dto/presents_list_dto.dart';
import '../../data/mapper/presents_list_mapper.dart';
import '../model/presents_list_model.dart';
import '../repository/presents_list_repository.dart';

class PostPresentsListUseCase {
  PostPresentsListUseCase({
    required PresentsListRepository presentsListRepository,
  }) : _presentsListRepository = presentsListRepository;

  final PresentsListRepository _presentsListRepository;

  Future<void> execute(
      {required String myListDocId, required PresentsListModel myList}) async {
    PresentsListDto result = PresentsListMapper.toDTO(myList);
    await _presentsListRepository.postFirebaseMyPresentsList(
        myListDocId, result);
  }
}
