import 'package:flutter/material.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/data/repository/local/favorite_local.dart';
import 'package:marvel/presentation/screens/character_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}
class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences _prefs;
  late FavoriteCharactersRepository _repository;
  List<Character> _favoriteCharacters = [];

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences().then((_) {
      _repository = FavoriteCharactersRepository(_prefs);
      _loadFavoriteCharacters();
    });
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadFavoriteCharacters() async {
    final favoriteCharacters = await _repository.loadFavoriteCharacters();
    setState(() {
      _favoriteCharacters = favoriteCharacters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Characters'),
      ),
      body: ListView.builder(
        itemCount: _favoriteCharacters.length,
        itemBuilder: (context, index) {
          final character = _favoriteCharacters[index];
          return ListTile(
            title: Text(character.name),
            subtitle: Text('ID: ${character.id}'),
            leading: Image.network(character.imageUrl),
            onTap: () {
              // Navigate to character details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CharacterDetailsScreen(character: character),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
