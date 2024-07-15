import 'package:html/parser.dart' as parser;

import '../../../domain/repository/link_preview_extractor.dart';
import '../../core/result.dart';
import '../../data_source/get_meta_data.dart';

class TeddytoysLinkPreviewExtractor implements LinkPreviewExtractor {
  @override
  Future<Result<Map<String, String>>> extractData(String url) async {
    final Result teddytoysPreviewResult =
        await GetMetaData().fetchLinkPreview(url);

    return teddytoysPreviewResult.when(success: (response) {
      try {
        var document = parser.parse(response.body);
        String? title;
        String? imageUrl;
        var elements = document.getElementsByTagName('meta');
        elements.forEach((tmp) {
          // 타이틀 추출
          if (tmp.attributes['property'] == 'og:title') {
            title = tmp.attributes['content'];
          }
          // 이미지 URL 추출
          if (tmp.attributes['property'] == 'og:image') {
            imageUrl = tmp.attributes['content'];
          }
        });
        if (title != null && imageUrl != null) {
          return Result.success({
            'title': title!,
            'imageUrl': imageUrl!,
          });
        } else {
          throw Exception('Failed to extract data from Teddy Toys');
        }
      } catch (e) {
        return Result.error('getTeddyToysMetaData: $e');
      }
    }, error: (message) {
      return Result.error(message);
    });
  }
}