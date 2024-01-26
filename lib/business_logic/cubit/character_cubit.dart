import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../data/repository/character_repository.dart';
import 'character_state.dart';

import '../../data/models/character.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  List<Character> characters = [];

  CharacterCubit({required this.characterRepository})
      : super(CharacterInitial());

  Future<List<Character>> getAllCharacter() async {
    try {
      final characters = await characterRepository.getAllCharacter();
      emit(CharacterLoaded(characters));
      this.characters = characters;
      print(characters );
      return characters;
    } catch (error) {
      // Handle error if the repository call fails
      emit(CharacterError(error.toString()));
      return [];
    }
  }
 void getCharacterQuotes(String charName) async {
    try {
      final quote = await characterRepository.getCharacterQuote(charName);
      emit(QuotesLoaded(quote));
      print(quote );
    } catch (error) {
      // Handle error if the repository call fails
      emit(CharacterError(error.toString()));
    }
  }
  // List<Character> getAllCharacter() {
  //   characterRepository.getAllCharacter().then((characters) {
  //     emit(CharacterLoaded(characters));
  //     this.characters = characters;
  //   });
  //   print(characters);
  //   return characters;
  // }
}
