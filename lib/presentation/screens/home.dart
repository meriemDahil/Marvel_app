
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/models/character_model.dart';

import 'package:marvel/presentation/cubit/charactercubit_cubit.dart';
import 'package:marvel/presentation/cubit/charactercubit_state.dart';
import 'package:marvel/presentation/screens/character_details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersCubit>().fetchMarvelCharacters();
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to launch URL: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCharacterCard(Character character) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailsScreen(character: character),
          ),
        );
      },
      child: Container(
        
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 70.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Color.fromARGB(255, 194, 33, 33),
          
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.network(
              character.imageUrl,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 12.0),
            Text('ID: ${character.id}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(character.name, style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.link),
                  onPressed: () => _launchURL(character.wikiUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Characters'),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (state is CharactersLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CharactersLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return _buildCharacterCard(character);
              },
            );
          } else if (state is CharactersError) {
            return const Center(child: Text('No data available'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
