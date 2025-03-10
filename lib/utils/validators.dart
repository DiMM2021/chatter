class Validators {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Введите email';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Введите корректный email';
    }

    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Введите пароль';
    }

    final passwordRegex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(password)) {
      return 'Пароль должен содержать минимум 8 знаков, включая символы и заглавные буквы';
    }

    return null;
  }
}
