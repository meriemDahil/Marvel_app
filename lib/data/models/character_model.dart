import 'package:marvel/data/models/comic_model.dart';

class Character {
  final int id;
  final String name;
  final String imageUrl;
  final String wikiUrl;
  final List<Comic> comics;

  Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.wikiUrl,
    required this.comics,
  });

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'wikiUrl': wikiUrl,
      'comics': comics.map((comic) => comic.toJson()).toList(),
    };
  }
   factory Character.fromJson(Map<String, dynamic> json) {
    // Deserialize a Character object from a JSON map
    return Character(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      wikiUrl: json['wikiUrl'],
      comics: (json['comics'] as List<dynamic>).map((comicJson) => Comic.fromJson(comicJson)).toList(),
    );
  }

}
