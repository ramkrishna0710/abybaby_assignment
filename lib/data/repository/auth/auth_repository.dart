import 'dart:convert';
import 'package:assignment_abybaby/core/api/api_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/auth/login_response_model.dart';
import '../../model/auth/user_model.dart';
import '../../../core/api/api_response.dart';
import '../../../core/api/app_req_end_point.dart';


class AuthRepository {
  Future<ApiResponse<LoginResponseModel>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(AppReqEndPoint.userLogin),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse<LoginResponseModel>.fromJson(
          decoded,
              (data) => LoginResponseModel.fromJson(
            data as Map<String, dynamic>,
          ),
        );
      } else {
        throw ApiException(decoded["message"] ?? "Login failed");
      }
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ApiResponse<UserModel>> userRegistration({required String name, required String email, required String password, required String gender, required String phone})async{
    try{

      final response = await http.post(
        Uri.parse(AppReqEndPoint.userRegistration),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "gender": gender.toLowerCase(),
          "phone": phone,
        }),
      );

      final decoded = jsonDecode(response.body);

      // debugPrint(decoded);
      if (response.statusCode == 200) {
        return ApiResponse<UserModel>.fromJson(
          decoded,
              (data) => UserModel.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(decoded["message"] ?? "Registration failed");
      }

    }catch(e,stack){
      debugPrintStack(stackTrace: stack);
      rethrow;
    }
  }

}