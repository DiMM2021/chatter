import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/chat_bloc.dart';

class ChatSearchBar extends StatelessWidget {
  final ValueNotifier<String> searchQueryNotifier;

  const ChatSearchBar({super.key, required this.searchQueryNotifier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, query, child) {
          return TextField(
            decoration: InputDecoration(
              hintText: "Поиск",
              hintStyle: Theme.of(context).textTheme.labelLarge,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(9.0),
                child: SvgPicture.asset('assets/icons/custom_search.svg'),
              ),
            ),
            onChanged: (value) {
              searchQueryNotifier.value = value;
              context.read<ChatBloc>().add(SearchChats(value));
            },
          );
        },
      ),
    );
  }
}
