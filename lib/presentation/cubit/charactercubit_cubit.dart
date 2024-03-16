import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/data/repository/character_repo.dart';
import 'package:marvel/presentation/cubit/charactercubit_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepsitory characterRepsitory;
  
  CharactersCubit({required this.characterRepsitory}) : super(CharactersInitial());
    final int charactersPerPage = 10;
  int currentPage = 0;
  bool hasMoreCharacters = true;
  List<Character> characters = [];

  Future<void> fetchNextPage() async {
    if (hasMoreCharacters) {
      try {
        final newCharacters = await characterRepsitory.fetchMarvelCharacters(currentPage + 1);
        currentPage++;
        if (newCharacters.isEmpty) {
          hasMoreCharacters = false;
        }
        characters.addAll(newCharacters);
        emit(CharactersLoaded(characters));
      } catch (e) {
        emit(CharactersError('Failed to fetch Marvel characters: $e'));
      }
    }
  }

  Future<void> fetchMarvelCharacters() async {
    emit(CharactersLoading());
    try{
      
        final List<Character> characters = await characterRepsitory.fetchMarvelCharacters(0);
         emit(CharactersLoaded(characters));
    }catch(e){
       emit(CharactersError('Failed to fetch Marvel characters: $e'));

    }
    
   
  }
  

  
}
