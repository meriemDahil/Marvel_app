import '../../data/models/character_model.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class CharactersError extends CharactersState {
  final String errorMessage;

  CharactersError(this.errorMessage);
}
