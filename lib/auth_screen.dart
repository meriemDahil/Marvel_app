
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';
import 'package:marvel/presentation/screens/home.dart';
import 'package:marvel/presentation/screens/welcome_page.dart';
import 'package:marvel/presentation/widgets/nav_bar.dart';
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
            return SpinKitRotatingCircle(
                  color: Colors.red,
                  size: 50.0); 
          case AuthenticationStatus.authenticated:
            return NavBar(); // Navigate to Home screen
          case AuthenticationStatus.unauthenticated:
            return WelcomePage(); // Navigate to WelcomePage screen
          default:
            return Container(); 
        }
      },
    );
  }
}
