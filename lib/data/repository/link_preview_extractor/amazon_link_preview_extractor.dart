import 'package:Birthday_Presents_List/data/data_source/get_meta_data.dart';
import 'package:html/parser.dart' as parser;

import '../../../domain/repository/link_preview_extractor.dart';
import '../../core/result.dart';

class AmazonLinkPreviewExtractor implements LinkPreviewExtractor {
  @override
  Future<Result<Map<String, String>>> extractData(String url) async {
    final Result amazonPreviewResult =
        await GetMetaData().fetchLinkPreview(url);
    return amazonPreviewResult.when(success: (response) {
      try {
        var document = parser.parse(response.body);
        String? title = document.querySelector('#productTitle')?.text.trim();
        String? imageUrl =
            document.querySelector('#imgTagWrapperId img')?.attributes['src'];
        if (title != null && imageUrl != null) {
          return Result.success({
            'title': title,
            'imageUrl': imageUrl,
          });
        } else {
          throw Exception('Failed to extract data from Amazon');
        }
      } catch (e) {
        return Result.error('getAmazonMetaData: $e');
      }
    }, error: (message) {
      return Result.error(message);
    });
  }
}
