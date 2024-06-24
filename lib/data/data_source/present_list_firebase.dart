import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/simple_logger.dart';
import '../core/result.dart';
import '../dto/presents_list_dto.dart';

class PresentListFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result<void>> postPresentsListData(
      String myListDocId, PresentsListDto myList) async {
    try {
      await _firestore.collection('presentsList').doc(myListDocId).set({
        'name': myList.name,
        'birthYear': myList.birthYear,
        'createdDate': myList.createdDate,
        'links': myList.links,
      });

      // 성공 시 Result.success(null) 반환
      return const Result.success(null);
    } catch (e) {
      // Firestore 예외 발생 시 오류 메시지 반환
      logger.info('Firestore 통신 에러 => $e');
      return Result.error(e.toString());
    }
  }

  Future<Result<PresentsListDto>> getPresentListData(String myListDocId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('presentsList').doc(myListDocId).get();

      return Result.success(PresentsListDto.fromJson(docSnapshot[myListDocId]));
    } catch (e) {
      // Firestore 예외 발생 시 오류 메시지 반환
      logger.info('Firestore 통신 에러 => $e');
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> updatePresentListData(
      String myListDocId, String fieldName, dynamic editedValue) async {
    try {
      await _firestore
          .collection('presentsList')
          .doc(myListDocId)
          .update({fieldName: editedValue});

      // 성공 시 Result.success(null) 반환
      return const Result.success(null);
    } catch (e) {
      // Firestore 예외 발생 시 오류 메시지 반환
      logger.info('Firestore 통신 에러 => $e');
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> deletePresentListData(String myListDocId) async {
    try {
      await _firestore.collection('presentsList').doc(myListDocId).delete();

      // 성공 시 Result.success(null) 반환
      return const Result.success(null);
    } catch (e) {
      // Firestore 예외 발생 시 오류 메시지 반환
      logger.info('Firestore 통신 에러 => $e');
      return Result.error(e.toString());
    }
  }
}
