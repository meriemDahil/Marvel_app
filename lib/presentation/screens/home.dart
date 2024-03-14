import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Column(
        children: [
          Text('home'),
          ElevatedButton(
                    onPressed: () {
                      // Call signIn method of AuthenticationCubit to handle authentication
                      context.read<CubitCubit>().signOut(
                           
                          );
                    },
                    child: Text('Sign out'),
                  ),
        ],
      )),
    );
  }
}