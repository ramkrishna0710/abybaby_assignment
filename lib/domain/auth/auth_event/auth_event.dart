abstract class AuthEvent {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String gender;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.gender,
  });

}
