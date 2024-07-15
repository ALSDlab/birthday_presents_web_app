import 'package:Birthday_Presents_List/data/repository/link_preview_extractor/germantoys_link_preview_extractor.dart';
import 'package:Birthday_Presents_List/data/repository/link_preview_extractor/smyths_link_preview_extractor.dart';
import 'package:Birthday_Presents_List/data/repository/link_preview_extractor/teddytoys_link_preview_extractor.dart';

import '../../data/repository/link_preview_extractor/amazon_link_preview_extractor.dart';
import '../repository/link_preview_extractor.dart';

class GetLinkPreviewUseCase {
  Future<Map<String, String>> execute(String url) async {
    // 각 도메인에 대해 추출기를 매핑합니다.
    final Map<String, LinkPreviewExtractor> extractors = {
      'amazon': AmazonLinkPreviewExtractor(),
      'amzn': AmazonLinkPreviewExtractor(),
      'smythstoys': SmythsLinkPreviewExtractor(),
      'teddytoys': TeddytoysLinkPreviewExtractor(),
      'german-toys': GermantoysLinkPreviewExtractor(),
    };

    // URL에서 해당 도메인을 찾습니다.
    final extractor = extractors.entries
        .firstWhere(
          (entry) => url.contains(entry.key),
          orElse: () => throw Exception('Unsupported URL'),
        )
        .value;

    // 추출기를 사용하여 데이터를 가져옵니다.
    final result = await extractor.extractData(url);

    return result.when(
      success: (data) {
        return data;
      },
      error: (message) => throw Exception(message),
    );
  }
}
