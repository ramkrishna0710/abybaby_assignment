
import 'package:assignment_abybaby/data/model/dealer/pin_code_model.dart';

class CityModel {
  final int id;
  final String name;
  final PinCodeModel pinCode;

  CityModel({
    required this.id,
    required this.name,
    required this.pinCode,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      pinCode: PinCodeModel.fromJson(json['pin_code']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "pin_code": pinCode.toJson(),
    };
  }
}
