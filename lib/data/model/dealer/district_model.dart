import 'city_model.dart';

class DistrictModel {
  final int id;
  final String name;
  final CityModel city;

  DistrictModel({
    required this.id,
    required this.name,
    required this.city,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      city: CityModel.fromJson(json['city']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "city": city.toJson(),
    };
  }
}
