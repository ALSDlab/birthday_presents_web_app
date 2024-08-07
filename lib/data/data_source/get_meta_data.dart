import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

import '../../utils/simple_logger.dart';
import '../core/result.dart';

class GetMetaData {
  Future<Result<Response>> fetchLinkPreview(String url) async {
    // 프록시 설정
    var proxyAddress = 'p.webshare.io';
    var proxyUsername = 'haurajul-rotate';
    var proxyPassword = 'pyxbd1e7meit';

    HttpClient httpClient = HttpClient();

    httpClient.findProxy = (uri) {
      return 'PROXY $proxyAddress:80';
    };


    httpClient.addProxyCredentials(
      proxyAddress,
      80,
      '',
      HttpClientBasicCredentials(proxyUsername, proxyPassword),
    );

    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        return Result.success(response);
      } else {
        return Result.error('response.statusCode => ${response.statusCode}');
      }
    } catch (e) {
      logger.info('http 통신 에러 => $e');
      throw Exception(e);
    } finally {
      ioClient.close();
    }
  }
}
