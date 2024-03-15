
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';
import 'package:marvel/presentation/screens/home.dart';
import 'package:marvel/presentation/screens/welcome_page.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitCubit, AuthenticationStatus>(
    
          
         
      builder: (context, state) {
        switch (state) {
          case AuthenticationStatus.initial :
            return CircularProgressIndicator(); // Show loading indicator
          case AuthenticationStatus.authenticated:
            return CharactersScreen(); // Navigate to Home screen
          case AuthenticationStatus.unauthenticated:
            return WelcomePage(); // Navigate to WelcomePage screen
          default:
            return Container(); // Handle other states if needed
        }
      },
    );
  }
}
