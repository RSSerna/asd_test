import 'package:equatable/equatable.dart';

//Used only for sending parameters to the CleanRepository
class CleanParams extends Equatable {
  final String email;
  final String newPassword;
  final String password;

  const CleanParams({
    required this.email,
    required this.newPassword,
    required this.password,
  });

  @override
  List<Object?> get props => [email, newPassword, password];
}
