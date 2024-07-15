import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../utils/simple_logger.dart';
import '../core/result.dart';

class GetMetaData {
  Future<Result<Response>> fetchLinkPreview(String url) async {
    try {
final client = http.Client();
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Result.success(response);
      } else {
        return Result.error('response.statusCode => ${response.statusCode}');
      }
    } catch (e) {
      logger.info('http 통신 에러 => $e');
      throw Exception(e);
    }
  }
}