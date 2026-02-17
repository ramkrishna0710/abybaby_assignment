class PinCodeModel {
  final int id;
  final String name;

  PinCodeModel({
    required this.id,
    required this.name,
  });

  factory PinCodeModel.fromJson(Map<String, dynamic> json) {
    return PinCodeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
