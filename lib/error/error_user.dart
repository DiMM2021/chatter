class ErrorUser {
  static String getErrorMessage(dynamic error) {
    switch (error.toString()) {
      case "user-not-authenticated":
        return "Ошибка: пользователь не авторизован";
      case "token-not-received":
        return "Ошибка: не удалось получить токен";
      case "request-failed":
        return "Ошибка запроса к серверу";
      default:
        return "Неизвестная ошибка: $error";
    }
  }
}
