import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/character_cubit.dart';
import 'data/api/character_api.dart';
import 'data/models/character.dart';
import 'data/repository/character_repository.dart';

import 'costants/strings.dart';
import 'presentatiton/screens/character_screen.dart';
import 'presentatiton/screens/characterdetails_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharacterCubit characterCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterAPI());
    characterCubit = CharacterCubit(characterRepository: characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => characterCubit,
                  child: const CharacterSrceen(),
                ));
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharacterCubit(characterRepository: characterRepository),
                  child: CharacterDetailsScreen(
                    character: character,
                  ),
                ));
    }
  }
}
