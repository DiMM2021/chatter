part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final bool isEmailVerified;

  AuthSuccess({required this.isEmailVerified});

  @override
  List<Object?> get props => [isEmailVerified];
}

class AuthEmailNotVerified extends AuthState {}

class AuthVerificationEmailSent extends AuthState {
  final String message;

  AuthVerificationEmailSent(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthPasswordResetSuccess extends AuthState {
  final String message;

  AuthPasswordResetSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {}
