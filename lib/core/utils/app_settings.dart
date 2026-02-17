import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_constant.dart';

class AppSettings {
  static final storage = FlutterSecureStorage();

  // Save access token data
  static Future<void> saveAccessToken(String value) async {


    await storage.write(
      key: AppConstant.kAccessToken,
      value: value,
    );
  }

  static Future<String?> getAccessToken() async {
    final token = await storage.read(key: AppConstant.kAccessToken);
    if (token == null) return null;
    return token;

  }

  static Future<void> clearAccessToken() async {
    await storage.delete(key: AppConstant.kAccessToken);
  }


}