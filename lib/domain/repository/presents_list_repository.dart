import '../../data/core/result.dart';
import '../../data/dto/presents_list_dto.dart';
import '../model/presents_list_model.dart';

abstract interface class PresentsListRepository {
  Future<Result<void>> postFirebaseMyPresentsList(
      String myListDocId, PresentsListDto myList);

  Future<Result<PresentsListModel>> getFirebasePresentsList(String docId);

  Future<Result<void>> updateFirebaseList(String myListDocId, Map<String, dynamic> updatedFactor);

}
