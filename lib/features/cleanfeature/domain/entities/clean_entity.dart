import 'dart:convert';

//Used as an entity that will be used in the Screens
class CleanEntity {
  final String email;
  final String newPassword;
  final String password;

  const CleanEntity({
    required this.email,
    required this.newPassword,
    required this.password,
  });

  CleanEntity copyWith({
    String? email,
    String? newPassword,
    String? password,
  }) {
    return CleanEntity(
      email: email ?? this.email,
      newPassword: newPassword ?? this.newPassword,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'newPassword': newPassword,
      'password': password,
    };
  }

  factory CleanEntity.fromMap(Map<String, dynamic> map) {
    return CleanEntity(
      email: map['email'] ?? '',
      newPassword: map['newPassword'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CleanEntity.fromJson(String source) =>
      CleanEntity.fromMap(json.decode(source));

  @override
  String toString() =>
      'CleanEntity(email: $email, newPassword: $newPassword, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CleanEntity &&
        other.email == email &&
        other.newPassword == newPassword &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ newPassword.hashCode ^ password.hashCode;
}
