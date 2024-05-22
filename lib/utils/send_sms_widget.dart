import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


import '../env/env.dart';
import 'simple_logger.dart';

void sendSMS(String servicePhoneNo, String phoneNumber, String content) async {
  final body = {
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
  final jsonBody = jsonEncode(body);

  const String space = ' '; // 한 칸 공백
  const String newLine = '\n'; // 개행 문자
  const String method = 'POST';
  const String serviceId = Env.sensServiceId;
  const String uri = '/sms/v2/services/$serviceId/messages';
  final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  const String accessKey = Env.naverCloudAccessKeyId;
  const String secretKey = Env.naverCloudSecretKey;
  final String hmac = method + space + uri + newLine + timestamp + newLine + accessKey;

  final hmacSha256 = Hmac(sha256, utf8.encode(secretKey));
  final digest = hmacSha256.convert(utf8.encode(hmac));
  final String signature = base64.encode(digest.bytes);

  const String apiUrl = '${Env.sensApiUrl}/$serviceId/messages';
  print(apiUrl);
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'x-ncp-apigw-timestamp': timestamp,
    'x-ncp-iam-access-key': accessKey,
    'x-ncp-apigw-signature-v2': signature
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: jsonBody,
  );

  logger.info(response.body);
}
