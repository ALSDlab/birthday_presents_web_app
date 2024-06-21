import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/core/result.dart';
import '../../utils/simple_logger.dart';

class LoadPresentsListUseCase {
  // shared_preferences를 이용하여 리스트를 불러오는 기능 구현
  static const String _key = 'presentsList';

  Future<Result<List<Map<String, dynamic>>>> execute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? savedPresentsList = prefs.getString(_key);

      if (savedPresentsList != null) {
        // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환
        final jsonList = jsonDecode(savedPresentsList) as List<dynamic>;
        return Result.success(
            jsonList.map((e) => Map<String, dynamic>.from(e as Map)).toList());
      } else {
        return const Result.success([]);
      }
    } catch (e) {
      // 예외 발생 시 오류 메시지 반환
      logger.info('Shared_preferences load 에러 => $e');
      return Result.error(e.toString());
    }
  }
}