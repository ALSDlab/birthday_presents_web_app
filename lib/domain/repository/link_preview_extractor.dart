import '../../data/core/result.dart';

abstract class LinkPreviewExtractor {
  Future<Result<Map<String, String>>> extractData(String url);
}