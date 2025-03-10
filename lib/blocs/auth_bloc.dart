import 'package:bloc/bloc.dart';
import 'package:chatter/error/error_message.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime? _lastVerificationTime;

  AuthBloc() : super(AuthInitial()) {
    on<AuthSignIn>(_onLogin);
    on<AuthSignUp>(_onSignUp);
    on<AuthSendVerificationEmail>(_onSendVerificationEmail);
    on<AuthResendVerificationEmail>(_onResendVerificationEmail);
    on<AuthResetPassword>(_onResetPassword);
    on<AuthSignOut>(_onSignOut);
  }

  Future<void> _onLogin(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final user = _auth.currentUser;
      if (user != null && user.emailVerified) {
        emit(AuthSuccess(isEmailVerified: true));
      } else {
        emit(AuthEmailNotVerified());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(getFirebaseErrorMessage(e)));
    }
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    if (event.password != event.confirmPassword) {
      emit(AuthFailure('Неверный пароль'));
      return;
    }

    emit(AuthLoading());

    try {
      await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        emit(AuthEmailNotVerified());
      } else {
        emit(AuthFailure('Подтвердите'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(getFirebaseErrorMessage(e)));
    }
  }

  Future<void> _onSendVerificationEmail(
      AuthSendVerificationEmail event, Emitter<AuthState> emit) async {
    try {
      User? user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        if (_lastVerificationTime == null ||
            DateTime.now().difference(_lastVerificationTime!).inSeconds >= 30) {
          await user.sendEmailVerification();
          _lastVerificationTime = DateTime.now();
          emit(AuthVerificationEmailSent('Эмеил'));
        } else {
          final remainingTime =
              30 - DateTime.now().difference(_lastVerificationTime!).inSeconds;
          emit(AuthFailure('Подтвердите $remainingTime'));

        }
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(getFirebaseErrorMessage(e)));
    }
  }

  Future<void> _onResendVerificationEmail(
      AuthResendVerificationEmail event, Emitter<AuthState> emit) async {
    add(AuthSendVerificationEmail());
  }

  Future<void> _onResetPassword(
      AuthResetPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: event.email);
      emit(AuthPasswordResetSuccess('Подтвердите'));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(getFirebaseErrorMessage(e)));
    }
  }

  Future<void> _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    await _auth.signOut();
    emit(AuthLoggedOut());
  }
}
