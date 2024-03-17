import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/presentation/screens/favorite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}
class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  late SharedPreferences _prefs;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isFavorite = _prefs.containsKey(widget.character.id.toString());
    setState(() {});
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      _prefs.remove(widget.character.id.toString());
    } else {
      final characterJson = jsonEncode(widget.character.toJson()); // Convert to JSON string
      _prefs.setString(widget.character.id.toString(), characterJson);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.character.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.character.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Comics:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.character.comics.length,
              itemBuilder: (context, index) {
                final comic = widget.character.comics[index];
                return ListTile(
                  title: Text(comic.title),
                  trailing: IconButton(
                    icon: Icon(Icons.open_in_browser),
                    onPressed: () async {
                      final url = comic.url;
                     
                if (url != null) {
                  await launch(url);}
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed:// _toggleFavorite,
              (){Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavoriteScreen(),
          ),
        );},
              child: Text(_isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
            ),
          ),
        ],
      ),
    );
  }
}
