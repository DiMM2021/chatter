import 'package:auto_route/auto_route.dart';
import 'package:chatter/blocs/auth_bloc.dart';
import 'package:chatter/router/app_router.dart';
import 'package:chatter/theme/light_theme.dart';
import 'package:chatter/widgets/input_decoration.dart';
import 'package:chatter/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isObscured = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                context.router.replace(ChatListRoute());
              } else if (state is AuthEmailNotVerified) {
                context.router.replace(const VerifyEmailRoute());
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              bool isLoading = state is AuthLoading;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Вход в аккаунт',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: kBackgroundColor),
                    decoration: CustomInputDecoration.inputDecoration('Ваш email'),
                    autocorrect: false,
                    enableSuggestions: false,
                    validator: (value) {
                      return Validators.validateEmail(value ?? '');
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isObscured,
                    builder: (context, isObscured, child) {
                      return TextFormField(
                        obscureText: isObscured,
                        controller: _passwordController,
                        style: const TextStyle(color: kBackgroundColor),
                        decoration: CustomInputDecoration.inputDecoration('Ваш пароль').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscured ? Icons.visibility_off : Icons.visibility,
                              color: kIconHighlightColor,
                            ),
                            onPressed: () {
                              _isObscured.value = !_isObscured.value;
                            },
                          ),
                        ),
                        autocorrect: false,
                        enableSuggestions: false,
                        validator: (value) {
                          return Validators.validatePassword(value ?? '');
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                String email = _emailController.text.trim();
                                String password = _passwordController.text.trim();
                                context.read<AuthBloc>().add(
                                      AuthSignIn(email: email, password: password),
                                    );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kAccentColor,
                        padding: const EdgeInsets.all(18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: kBackgroundColor)
                          : const Text(
                              'Войти',
                              style: TextStyle(fontSize: 20, color: kBackgroundColor),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      context.router.push(SignupRoute());
                    },
                    child: const Text(
                      'Регистрация',
                      style: TextStyle(color: kIconHighlightColor, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.push(ResetPasswordRoute());
                    },
                    child: const Text(
                      'Сброс пароля',
                      style: TextStyle(color: kIconHighlightColor, fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
