import 'package:chatter/blocs/theme_cubit.dart';
import 'package:chatter/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleTheme extends StatelessWidget {
  const ToggleTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: context.watch<ThemeCubit>().state.brightness == Brightness.dark,
      onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
      activeColor: green,
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.shade300,
    );
  }
}
