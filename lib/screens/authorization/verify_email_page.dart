import 'package:auto_route/auto_route.dart';
import 'package:chatter/blocs/auth_bloc.dart';
import 'package:chatter/router/app_router.dart';
import 'package:chatter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthVerificationEmailSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email,
                  size: 80,
                  color: kPrimaryColor,
                ),
                const SizedBox(height: 20),
                Text(
                  'Подтверждение почты',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Перейдите в свою почту и подтвердите регистрацию',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthSendVerificationEmail());
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(kAccentColor),
                    padding: WidgetStateProperty.all(const EdgeInsets.only(
                        top: 18.0, right: 50.0, left: 50.0, bottom: 18.0)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text('Запросить снова', style: TextStyle(color: white),),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context.router.push(SigninRoute());
                  },
                  child: Text(
                    'Войти',
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
