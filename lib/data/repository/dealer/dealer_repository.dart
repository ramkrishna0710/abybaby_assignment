import 'dart:convert';
import 'package:assignment_abybaby/core/api/api_exception.dart';
import 'package:assignment_abybaby/data/model/dealer/notification_model.dart';
import 'package:assignment_abybaby/my_app.dart';
import 'package:assignment_abybaby/route/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../../core/api/app_req_end_point.dart';
import '../../../core/utils/app_settings.dart';
import '../../model/dealer/dealer_enum.dart';

class DealerRepository {
  Future<List<NotificationModel>> getDealerNotification({
    int page = 0,
    int pageLimit = 10,
    NotificationType? notificationType,
    NotificationCategory? category,
    NotificationLanguage? language,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(AppReqEndPoint.dealerNotificationList),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${await AppSettings.getAccessToken()}",
        },
        body: jsonEncode({
          "type": notificationType?.name,
          "category": category?.name,
          "language": language?.name,
          "skip": page * pageLimit,
          "take": pageLimit,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(decoded['message']);
        return (decoded['data']['notification_data'] as List)
            .map((e) => NotificationModel.fromJson(e))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('Logout');
      } else {
        throw ApiException(decoded["message"] ?? "Login failed");
      }
    } catch (e) {
      rethrow;
    }
  }
}
