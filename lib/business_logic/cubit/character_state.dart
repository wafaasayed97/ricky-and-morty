import 'package:flutter/material.dart';

import '../../data/models/character.dart';
import '../../data/models/quote.dart';


@immutable
abstract class CharacterState{}

class CharacterInitial extends CharacterState{}
class CharacterLoaded extends CharacterState{
  final List<Character> characters ;

  CharacterLoaded(this.characters);

}
class CharacterError extends CharacterState {
  final String errorMessage;

  CharacterError(this.errorMessage);

  List<Object> get props =>
      [errorMessage]; // Implement if needed for state equality

  @override
  String toString() {
    return 'CharacterError: $errorMessage';
  }
}
class QuotesLoaded extends CharacterState{
  final List<Quote> quote ;

  QuotesLoaded(this.quote);

}