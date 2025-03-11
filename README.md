# Chatter

Прототип мессенджера на Flutter с использованием Firebase для регистрации, авторизации и push-уведомлений.

## Установка необходимых инструментов

Перед началом убедитесь, что у вас установлены:

- **Flutter**: [Инструкция по установке](https://flutter.dev/docs/get-started/install)
- **Dart** (устанавливается вместе с Flutter)
- **Git**: [Скачать Git](https://git-scm.com/downloads)
- **Android Studio** (для работы с Android) или **Xcode** (для iOS)
- **Firebase CLI** (для работы с Firebase, [установка здесь](https://firebase.google.com/docs/cli))

Проверьте, что Flutter установлен корректно:
flutter doctor

## Клонирование репозитория

Склонируйте проект с GitHub и перейдите в его папку:

git clone https://github.com/DiMM2021/chatter.git
cd chatter

## Установка зависимостей
flutter pub get

## Архитектура проекта
- **lib/** — основная папка с кодом приложения (для Flutter)
  - **api/** — работа с Firebase для push-уведомлений
  - **blocs/** — управление состоянием с помощью BLoC
  - **error/** — ошибки для пользователя Firebase
  - **models/** — модель для взаимодействия с Hive
  - **router/** — роуты 
  - **screens/** — экраны для взаимодействия с пользователем 
  - **theme/** — светлая и темная темы, snack-bar
  - **utils/** — вспомогательные функции
  - **widgets/** — виджеты

## Запуск приложения
flutter run 


