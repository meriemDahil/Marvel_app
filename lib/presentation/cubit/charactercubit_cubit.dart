import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/data/repository/character_repo.dart';
import 'package:marvel/presentation/cubit/charactercubit_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepsitory characterRepsitory;
  
  CharactersCubit({required this.characterRepsitory}) : super(CharactersInitial());
 
  Future<void> fetchMarvelCharacters() async {
    emit(CharactersLoading());
    try{
      
        final List<Character> characters = await characterRepsitory.fetchMarvelCharacters(0);
         emit(CharactersLoaded(characters));
    }catch(e){
       emit(CharactersError('Failed to fetch Marvel characters: $e'));
        print('Failed to fetch Marvel characters: $e');


    }
    
   
  }
  

  
}
