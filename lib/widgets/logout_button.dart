import 'package:auto_route/auto_route.dart';
import 'package:chatter/blocs/auth_bloc.dart';
import 'package:chatter/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          context.router.replaceAll([SigninRoute()]);
        }
      },
      child: IconButton(
        onPressed: () {
          context.read<AuthBloc>().add(AuthSignOut());
        },
        icon: const Icon(Icons.exit_to_app),
      ),
    );
  }
}
