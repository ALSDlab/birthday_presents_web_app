import '../../domain/model/presents_list_model.dart';
import '../../domain/repository/presents_list_repository.dart';
import '../core/result.dart';
import '../data_source/present_list_firebase.dart';
import '../dto/presents_list_dto.dart';
import '../mapper/presents_list_mapper.dart';

class PresentsListRepositoryImpl implements PresentsListRepository {
  // 선정한 선물리스트 관련정보 저장하기(CREATE)
  @override
  Future<Result<void>> postFirebaseMyPresentsList(
      String myListDocId, PresentsListDto myList) async {
    final result =
        await PresentListFirebase().postPresentsListData(myListDocId, myList);

    return result.when(
      success: (data) {
        try {
          return Result.success(data);
        } catch (e) {
          return Result.error('PresentListRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  // 선정된 선물리스트 관련정보 가져오기(READ)
  @override
  Future<Result<PresentsListModel>> getFirebasePresentsList(
      String docId) async {
    final result = await PresentListFirebase().getPresentListData(docId);

    return result.when(
      success: (data) {
        try {
          PresentsListModel presentListModel = PresentsListMapper.fromDTO(data);
          return Result.success(presentListModel);
        } catch (e) {
          return Result.error('PresentListRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  @override
  Future<Result<void>> updateFirebaseList(String myListDocId, Map<String, dynamic> updatedFactor) async {
    final result =
        await PresentListFirebase().updatePresentListData(myListDocId, updatedFactor);

    return result.when(
      success: (data) {
        try {
          return Result.success(data);
        } catch (e) {
          return Result.error('PresentListRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
