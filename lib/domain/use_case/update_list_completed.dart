import 'package:Birthday_Presents_List/data/core/result.dart';

import '../repository/presents_list_repository.dart';

class UpdateListCompletedUseCase {
  UpdateListCompletedUseCase({
    required PresentsListRepository presentsListRepository,
  }) : _presentsListRepository = presentsListRepository;

  final PresentsListRepository _presentsListRepository;

  Future<Result<void>> execute(
      {required String myListDocId, required bool value}) async {
    final result =
        await _presentsListRepository.updateListCompleted(myListDocId, value);

    return result.when(
      success: (data) => const Result.success(null),
      error: (message) => throw Exception(message),
    );
  }
}
