import 'country_model.dart';
import 'dealer_enum.dart';

class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String? image;
  final NotificationType? type;
  final NotificationLanguage? language;
  final NotificationCategory? category;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CountryModel country;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.type,
    required this.language,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.country,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      type: json['type']!=null? NotificationType.fromString(json['type']): null,
      language: json['language']!=null? NotificationLanguage.fromString(json['language']): null ,
      category: json['category']!=null? NotificationCategory.fromString(json['category']): null,
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      country: CountryModel.fromJson(json['country']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image": image,
      "type": type,
      "language": language,
      "category": category,
      "status": status,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "country": country.toJson(),
    };
  }
}
