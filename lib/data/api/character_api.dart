import 'package:dio/dio.dart';

import '../../costants/strings.dart';

class CharacterAPI {
  late Dio dio;
  late Dio quoteDio;

  CharacterAPI() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20), // 20 second
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacter() async {
    try {
      Response response = await dio.get('character');

      final data = response.data;

      // Check if 'results' field exists in the response and is a List
      if (data != null && data['results'] is List) {
        final characters = data['results'] as List<dynamic>;
        return characters;
      } else {
        throw Exception('Invalid API response structure');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuote() async {
    final category = 'funny';
    final apiURL = 'https://api.api-ninjas.com/v1/quotes?category=$category';
    final apiKey = 'nB6Kl9zeAxzAbejaq0Wlow==I0QtvCW642vYnXgr';

    final dio = Dio();
    dio.options.headers['X-Api-Key'] = apiKey;

    try {
      final response = await dio.get(apiURL);
      if (response.statusCode == 200) {
        final List<dynamic> quotes = response.data;
        return quotes;
      } else {
        print('Error: ${response.statusCode} - ${response.data}');
        return []; // Return an empty list on error
      }
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list on error
   }
  }


}
