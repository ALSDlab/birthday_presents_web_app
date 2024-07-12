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

      if (docSnapshot.exists) {
        // 데이터가 존재하는 경우
        Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>;

        return Result.success(PresentsListDto.fromJson(data));
      } else {
        return const Result.error('Document not exist');
      }
    } catch (e) {
      // Firestore 예외 발생 시 오류 메시지 반환
      logger.info('Firestore 통신 에러 => $e');
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> updatePresentListData(
      String myListDocId, List<Map<String, dynamic>> updatedFactors) async {
    try {
      await _firestore
          .collection('presentsList')
          .doc(myListDocId)
          .update({'links': updatedFactors});

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
