class UserModel {
  final String status;
  final int id;
  final String name;
  final String email;
  final String gender;
  final String phone;
  final String password;


  UserModel({
    required this.status,
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'] ?? '',
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'phone': phone,
      'password': password,
    };
  }
}
