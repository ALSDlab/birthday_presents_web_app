import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/.env/..env', useConstantCase: true)
abstract class Env {

  // ANDROID_APPLICATION_ID
  @EnviedField()
  static const String androidApplicationId = _Env.androidApplicationId;

  // IOS_APPLICATION_ID
  @EnviedField()
  static const String iosApplicationId = _Env.iosApplicationId;

  // NAVER_CLOUD_ACCESS_KEY_ID
  @EnviedField()
  static const String naverCloudAccessKeyId = _Env.naverCloudAccessKeyId;

  // NAVER_CLOUD_SECRET_KEY
  @EnviedField()
  static const String naverCloudSecretKey = _Env.naverCloudSecretKey;

  // SENS_API_URL
  @EnviedField()
  static const String sensApiUrl = _Env.sensApiUrl;

  // SENS_SERVICE_ID
  @EnviedField()
  static const String sensServiceId = _Env.sensServiceId;
}
