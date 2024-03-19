import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCharactersRepository {
  final SharedPreferences _prefs;

  FavoriteCharactersRepository(this._prefs);

  Future<List<Character>> loadFavoriteCharacters() async {
    List<Character> favoriteCharacters = [];
    _prefs.getKeys().forEach((key) {
      final characterJson = _prefs.getString(key);
      if (characterJson != null) {
        final characterMap = jsonDecode(characterJson);
        final character = Character.fromJson(characterMap);
        favoriteCharacters.add(character);
      }
    });
    return favoriteCharacters;
  }
}
