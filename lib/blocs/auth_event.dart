part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  AuthSignUp(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object> get props => [email, password, confirmPassword];
}

class AuthSendVerificationEmail extends AuthEvent {}

class AuthResendVerificationEmail extends AuthEvent {}

class AuthResetPassword extends AuthEvent {
  final String email;

  AuthResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}


class AuthSignOut extends AuthEvent {}
