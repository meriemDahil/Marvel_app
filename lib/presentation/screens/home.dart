import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/presentation/cubit/charactercubit_cubit.dart';
import 'package:marvel/presentation/cubit/charactercubit_state.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';


class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    // Call fetchMarvelCharacters() after CharactersCubit is initialized
    context.read<CharactersCubit>().fetchMarvelCharacters();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Characters'),
      ),
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          print('Received state: $state');
          if (state is CharactersLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CharactersLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return ListTile(
                  leading: Image.network(character.imageUrl),
                  title: Text(character.name),
                  subtitle: Text('ID: ${character.id}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Open wiki URL
                      // You can implement your preferred method to open URLs here
                    },
                    child: Text('Open Wiki'),
                  ),
                );
              },
            );
          } else if (state is CharactersError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
