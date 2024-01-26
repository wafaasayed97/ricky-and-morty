
import '../api/character_api.dart';
import '../models/character.dart';
import '../models/quote.dart';

class CharacterRepository{
  final CharacterAPI characterApi;

  CharacterRepository(this.characterApi);
  Future<List<Character>> getAllCharacter()async{
    final characters= await characterApi.getAllCharacter();
    print(characters);
    return characters.map((character) => Character.fromJson(character)).toList();
  }
  Future<List<Quote>> getCharacterQuote(String charName)async{
    final quotes= await characterApi.getCharacterQuote();
    print(quotes);
    return quotes.map((charQuote) => Quote.fromJson(charQuote)).toList();
  }

  }