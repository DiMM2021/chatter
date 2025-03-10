import 'package:auto_route/auto_route.dart';
import 'package:chatter/screens/authorization/reset_password_page.dart';
import 'package:chatter/screens/authorization/signin_page.dart';
import 'package:chatter/screens/authorization/signup_page.dart';
import 'package:chatter/screens/authorization/verify_email_page.dart';
import 'package:chatter/screens/chat_list_screen.dart';
import 'package:chatter/screens/chat_screen.dart';
import 'package:chatter/screens/firebase_stream.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: FirebaseStreamRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/verify-email',
          page: VerifyEmailRoute.page,
        ),
        AutoRoute(
          path: '/signup',
          page: SignupRoute.page,
        ),
        AutoRoute(
          path: '/signin',
          page: SigninRoute.page,
        ),
        AutoRoute(
          path: '/reset-password',
          page: ResetPasswordRoute.page,
        ),
        AutoRoute(
          path: '/chat-list',
          page: ChatListRoute.page,
        ),
      ];
}
