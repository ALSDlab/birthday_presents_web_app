import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/.env/..env', useConstantCase: true)
abstract class Env {
  // SAMPLE_ACCOUNT_INFO
  // @EnviedField()
  // static const String sampleAccountUserid = _Env.sampleAccountUserid;
  // @EnviedField()
  // static const String sampleAccountUsername = _Env.sampleAccountUsername;
  // @EnviedField()
  // static const String sampleAccountEmail = _Env.sampleAccountEmail;
  // @EnviedField()
  // static const String sampleAccountPassword = _Env.sampleAccountPassword;

  // ANDROID_APPLICATION_ID
  @EnviedField()
  static const String androidApplicationId = _Env.androidApplicationId;

  // IOS_APPLICATION_ID
  @EnviedField()
  static const String iosApplicationId = _Env.iosApplicationId;
}
