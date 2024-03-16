import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/auth_screen.dart';
import 'package:marvel/data/repository/auth_repository.dart';
import 'package:marvel/data/repository/character_repo.dart';
import 'package:marvel/data/repository/local/notification.dart';
import 'package:marvel/firebase_options.dart';
import 'package:marvel/presentation/cubit/charactercubit_cubit.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotification.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            CubitCubit(authRepository: FirebaseAuthRepository(), ),
      ),
      BlocProvider(
        create: (context) => CharactersCubit(characterRepsitory: CharacterRepsitoryImpl()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
