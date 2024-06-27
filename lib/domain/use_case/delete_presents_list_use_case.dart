import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/core/result.dart';
import '../../utils/simple_logger.dart';

class DeletePresentsListUseCase {
  Future<Result<void>> execute(Map<String, dynamic> item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? savedPresentsList = prefs.getString('presentsList');
      if (savedPresentsList != null) {
        // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환
        final Map<String, dynamic> jsonList = jsonDecode(savedPresentsList);

        // 각 리스트 요소를 Map<String, dynamic>으로 변환하고 삭제할 아이템 삭제
        final currentList = jsonList.map((key, value) {
          if (value is List) {
            // 기존 리스트에서 item 제거
            final updatedList = value
                .map((e) => Map<String, dynamic>.from(e))
                .where((e) => !mapEquals(e, item))
                .toList();
            return MapEntry(key, updatedList);
          } else {
            throw Exception('Invalid format: value is not a List');
          }
        });
        String jsonString = jsonEncode(currentList);
        prefs.setString('presentsList', jsonString);
      }
      return const Result.success(null);
    } catch (e) {
      logger.info('Error during removal: $e');
      return Result.error(e.toString());
    }
  }
}
