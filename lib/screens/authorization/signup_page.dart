import 'package:auto_route/auto_route.dart';
import 'package:chatter/blocs/auth_bloc.dart';
import 'package:chatter/theme/theme.dart';
import 'package:chatter/widgets/input_decoration.dart';
import 'package:chatter/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isObscured = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kPrimaryColor),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 100.0, right: 20.0, left: 20.0),
                  child: Form(
                    key: _formKey,
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        } else if (state is AuthEmailNotVerified) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Письмо для подтверждения email отправлено на вашу почту')),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Регистрация',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration:
                                  CustomInputDecoration.inputDecoration('Ваш email'),
                              autocorrect: false,
                              enableSuggestions: false,
                              validator: (value) => Validators.validateEmail(value ?? ''),
                            ),
                            const SizedBox(height: 20),
                            ValueListenableBuilder<bool>(
                              valueListenable: _isObscured,
                              builder: (context, isObscured, child) {
                                return TextFormField(
                                  obscureText: isObscured,
                                  controller: _passwordController,
                                  style: const TextStyle(color: Colors.white),
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  decoration: CustomInputDecoration.inputDecoration('Ваш пароль')
                                      .copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: kIconHighlightColor,
                                      ),
                                      onPressed: () {
                                        _isObscured.value = !isObscured;
                                      },
                                    ),
                                  ),
                                  validator: (value) =>
                                      Validators.validatePassword(value ?? ''),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            ValueListenableBuilder<bool>(
                              valueListenable: _isObscured,
                              builder: (context, isObscured, child) {
                                return TextFormField(
                                  obscureText: isObscured,
                                  controller: _confirmPasswordController,
                                  style: const TextStyle(color: Colors.white),
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  decoration: CustomInputDecoration.inputDecoration('Подтвердите пароль')
                                      .copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: kIconHighlightColor,
                                      ),
                                      onPressed: () {
                                        _isObscured.value = !isObscured;
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Подтвердите пароль';
                                    } else if (value != _passwordController.text) {
                                      return 'Пароли не совпадают';
                                    }
                                    return null;
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
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          String email =
                                              _emailController.text.trim();
                                          String password =
                                              _passwordController.text.trim();
                                          String confirmPassword =
                                              _confirmPasswordController.text
                                                  .trim();

                                          if (!isLoading) {
                                            context.read<AuthBloc>().add(
                                                  AuthSignUp(
                                                    email: email,
                                                    password: password,
                                                    confirmPassword:
                                                        confirmPassword,
                                                  ),
                                                );
                                          }
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
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text(
                                        'Войти',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
