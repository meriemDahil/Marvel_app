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
}
