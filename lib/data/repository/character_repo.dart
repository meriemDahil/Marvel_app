 
 
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/data/models/comic_model.dart';

abstract class CharacterRepsitory {
  Future<List<Character>> fetchMarvelCharacters(int page);
  
}
class CharacterRepsitoryImpl extends CharacterRepsitory{

@override
  Future<List<Character>> fetchMarvelCharacters(int page) async {
    const String publicKey = '6e145d4e69d4046cbb46449c730a4026';
    const String privateKey = 'd03872f0015c414a6a711a852efbccd6cc17b61f';
    const String baseUrl = 'http://gateway.marvel.com/v1/public/characters';

    final String ts = DateTime.now().millisecondsSinceEpoch.toString();
    final String hash = generateHash(ts, privateKey, publicKey);

    final String apiUrl =
        '$baseUrl?ts=$ts&apikey=$publicKey&hash=$hash';
        print(apiUrl);

    try {
      final Response response = await Dio().get(apiUrl);
      final List<Character> charactersList = [];

      final Map<String, dynamic> data = response.data['data'];
      final List<dynamic> results = data['results'];

      for (var characterData in results) {
        final String name = characterData['name'];
        final int id = characterData['id'];
        final String imageUrl = characterData['thumbnail']['path'] + '.' + characterData['thumbnail']['extension'];
 
      final List<dynamic> urls = characterData['urls'];
      String wikiUrl = '';
      for (var urlData in urls) {
        if (urlData['type'] == 'wiki') {
          wikiUrl = urlData['url'];
          break;
        }
      }

      // Parse comics 
      
      final List<Comic> comics = [];
      final List<dynamic> comicsData = characterData['comics']['items'];
      for (var comicData in comicsData) {
        final String comicTitle = comicData['name'];
        final String comicUrl = comicData['resourceURI'];
        comics.add(Comic(title: comicTitle, url: comicUrl));
      }

      final character = Character(id: id, name: name, imageUrl: imageUrl, wikiUrl: wikiUrl, comics: comics);
      charactersList.add(character);
    }

    return charactersList;
  } catch (e) {
    throw Exception('Failed to fetch Marvel characters: $e');
  }
}
  String generateHash(String ts, String privateKey, String publicKey) {
    final String preHash = '$ts$privateKey$publicKey';
    return md5.convert(utf8.encode(preHash)).toString();
  }
}