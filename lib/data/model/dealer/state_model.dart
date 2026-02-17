import 'district_model.dart';

class StateModel {
  final int id;
  final String name;
  final DistrictModel district;

  StateModel({
    required this.id,
    required this.name,
    required this.district,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      district: DistrictModel.fromJson(json['district']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "district": district.toJson(),
    };
  }
}
