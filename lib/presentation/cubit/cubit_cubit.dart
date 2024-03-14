import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marvel/data/repository/auth_repository.dart';


enum AuthenticationStatus { initial, authenticated, unauthenticated }
class CubitCubit extends Cubit<AuthenticationStatus> {
  final AuthRepository authRepository;
  late StreamSubscription<User?> _authSubscription;

  CubitCubit({required this.authRepository}) : super(AuthenticationStatus.initial) {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        emit(AuthenticationStatus.authenticated);
      } else {
        emit(AuthenticationStatus.unauthenticated);
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  Future<void> signUp({required String email, required String password, required String name}) async {
    try {
      final userModel = await authRepository.signUp(email: email, password: password, name: name);
      if (userModel != null) {
        emit(AuthenticationStatus.authenticated);
      } else {
        emit(AuthenticationStatus.unauthenticated);
      }
    } catch (e) {
      emit(AuthenticationStatus.unauthenticated); // Handle sign up failure
      print('Sign up error: $e');
    }
  }

  Future<void> signIn({required String email, required String password}) async {
  try {
    final userModel = await authRepository.signIn(email: email, password: password);
    if (userModel != null) {
      emit(AuthenticationStatus.authenticated);
    } else {
      emit(AuthenticationStatus.unauthenticated);
    }
  } catch (e) {
    // Handle sign in failure
    print('Sign in error: $e');
  }
}

  Future<void> signOut() async {
    try {
      await authRepository.signOut();
      emit(AuthenticationStatus.unauthenticated);
    } catch (e) {
      // Handle sign out failure
      print('Sign out error: $e');
    }
  }
}
