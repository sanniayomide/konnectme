import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static final EnvConfig _instance = EnvConfig._internal();
  factory EnvConfig() => _instance;
  EnvConfig._internal();

  late int _zegoAppId;
  int get zegoAppId => _zegoAppId;

  late String _zegoAppSign;
  String get zegoAppSign => _zegoAppSign;

  late String _clerkApiKey;
  String get clerkApiKey => _clerkApiKey;

  Future<void> initializing() async {
    await dotenv.load(fileName: ".env");

    final zegoAppIdStr = dotenv.env['ZEGO_APP_ID'];
    final zegoAppSignStr = dotenv.env['ZEGO_APP_SIGN'];
    final clerkApiKeyStr = dotenv.env['CLERK_API_KEY'];

    if (zegoAppIdStr == null ||
        zegoAppSignStr == null ||
        clerkApiKeyStr == null ||
        zegoAppIdStr.isEmpty ||
        zegoAppSignStr.isEmpty ||
        clerkApiKeyStr.isEmpty) {
      throw Exception(
        'Zego App ID, App Sign, and Clerk API Key are required in the .env file.',
      );
    }

    _zegoAppId = int.parse(zegoAppIdStr);
    _zegoAppSign = zegoAppSignStr;
    _clerkApiKey = clerkApiKeyStr;
  }
}
