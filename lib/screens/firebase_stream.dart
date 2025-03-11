import 'package:auto_route/auto_route.dart';
import 'package:chatter/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FirebaseStreamPage extends StatelessWidget {
  const FirebaseStreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(),
          );
        }
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        else if (snapshot.hasData) {
          final user = snapshot.data!;
          if (user.emailVerified) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.router.replace(ChatListRoute());
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.router.replace(const VerifyEmailRoute());
            });
          }
        }
        else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.router.replace(SigninRoute());
          });
        }
        return const Scaffold(body: SizedBox());
      },
    );
  }
}
