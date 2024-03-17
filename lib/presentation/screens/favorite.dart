import 'package:flutter/material.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/presentation/screens/character_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Import dart:convert for jsonDecode

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences _prefs;
  List<Character> _favoriteCharacters = [];

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFavoriteCharacters();
  }

  Future<void> _loadFavoriteCharacters() async {
    List<Character> favoriteCharacters = [];
    _prefs.getKeys().forEach((key) {
      final characterJson = _prefs.getString(key);
      if (characterJson != null) {
        final characterMap = jsonDecode(characterJson);
        final character = Character.fromJson(characterMap);
        favoriteCharacters.add(character);
      }
    });

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
