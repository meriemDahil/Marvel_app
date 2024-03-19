import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeModeType { light, dark }

class ThemeCubit extends Cubit<ThemeModeType> {
  ThemeCubit() : super(ThemeModeType.light);

  static final lightTheme = ThemeData.light().copyWith(
    
    primaryColor: Colors.black,
    
  );

  static final darkTheme = ThemeData.dark().copyWith(
  
    primaryColor: Colors.white,

  );

  void toggleTheme() {
    emit(state == ThemeModeType.light ? ThemeModeType.dark : ThemeModeType.light);
  }
}
