import '../model/presents_list_model.dart';
import '../repository/presents_list_repository.dart';

class GetPresentsListUseCase {
  GetPresentsListUseCase({
    required PresentsListRepository presentsListRepository,
  }) : _presentsListRepository = presentsListRepository;

  final PresentsListRepository _presentsListRepository;

  Future<PresentsListModel> execute(String docId) async {
    final result = await _presentsListRepository.getFirebasePresentsList(docId);

    return result.when(
      success: (data) => data,
      error: (message) => throw Exception(message),
    );
  }
}
