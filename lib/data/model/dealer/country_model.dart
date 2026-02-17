import 'package:assignment_abybaby/data/model/dealer/state_model.dart';

class CountryModel {
  final int id;
  final String name;
  final StateModel state;

  CountryModel({
    required this.id,
    required this.name,
    required this.state,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      state: StateModel.fromJson(json['state']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "state": state.toJson(),
    };
  }
}
