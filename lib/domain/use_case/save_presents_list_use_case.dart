import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/core/result.dart';
import '../../utils/simple_logger.dart';

class SavePresentsListUseCase {
  // shared_preferences를 이용하여 리스트에 담는 기능 구현
  static const String _key = 'presentsList';

  Future<Result<void>> execute(List<Map<String, dynamic>> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String jsonString = jsonEncode(items);
      prefs.setString(_key, jsonString);

      return const Result.success(null);
    } catch (e) {
      // Firestore 예외 발생 시 오류 메시지 반환
      logger.info('Shared_preferences save 에러 => $e');
      return Result.error(e.toString());
    }
  }
}
