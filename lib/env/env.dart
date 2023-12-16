import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: "CLOVA_API_KEY")
  static const String apiKey = _Env.apiKey;
  @EnviedField(varName: "NCP_API_KEY")
  static const String apiKeyPrimaryVal = _Env.apiKeyPrimaryVal;
}
