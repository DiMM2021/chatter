import 'package:firebase_auth/firebase_auth.dart';

String getFirebaseErrorMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'Пользователь не найден';
    case 'wrong-password':
      return 'Неверный пароль';
    case 'invalid-credential':
      return 'Пользователь не найден';
    case 'too-many-requests':
      return 'Слишком много запросов';
    case 'email-already-in-use':
      return 'Email уже зарегестрирован в системе';
    case 'network-request-failed':
      return 'Отсутствует интернет-соединение';
    default:
      return 'Неизвестная ошибка: ${e.message}';
  }
}
