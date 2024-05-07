import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


import '../../../env/env.dart';
import '../../../utils/simple_logger.dart';

Future<void> sendSMS(String servicePhoneNo, String phoneNumber, String content) async {
  var body = {
    "type": "SMS",
    "contentType": "COMM",
    "countryCode": "82",
    "from": servicePhoneNo,
    "content": "내용",
    "messages": [
      {
        "to": phoneNumber,
        "content": content
      }
    ]
  };
  var jsonBody = jsonEncode(body);

  var space = ' '; // 한 칸 공백
  var newLine = '\n'; // 개행 문자
  var method = 'POST';
  var serviceId = Env.sensServiceId;
  var uri = '/sms/v2/services/$serviceId/messages';
  var timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  var accessKey = Env.naverCloudAccessKeyId;
  var secretKey = Env.naverCloudSecretKey;
  var hmac = utf8.encode(method + space + uri + newLine + timestamp + newLine + accessKey);

  var digest = Hmac(sha256, utf8.encode(secretKey)).convert(hmac);
  var signature = base64.encode(digest.bytes);

  var apiUrl = '${Env.sensApiUrl}/$serviceId/messages';
  var response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'x-ncp-apigw-timestamp': timestamp,
      'x-ncp-iam-access-key': accessKey,
      'x-ncp-apigw-signature-v2': signature
    },
    body: jsonBody,
  );

  logger.info(response.body);
}
