import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marvel/data/repository/auth_repository.dart';


enum AuthenticationStatus { initial, authenticated, unauthenticated ,loading, ConnectedState, NotConnectedState}

class CubitCubit extends Cubit<AuthenticationStatus> {
  final AuthRepository authRepository;
  
  late StreamSubscription<User?> _authSubscription;
  late StreamSubscription? _subscription;

  CubitCubit({required this.authRepository}) : super(AuthenticationStatus.initial) {

    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        emit(AuthenticationStatus.authenticated);
      } else {
        emit(AuthenticationStatus.unauthenticated);
      }
    });
  }
  Future<void> signUp({required String email, required String password,}) async {
  try {
    final userModel = await authRepository.signUp(email: email, password: password, );
    if (userModel != null) {
      emit(AuthenticationStatus.authenticated);
    } else {
      emit(AuthenticationStatus.unauthenticated);
    }
  } catch (e) {
    emit(AuthenticationStatus.unauthenticated); 
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
    print('Sign in error: $e');
  }
}

  Future<void> signOut() async {
    try {
      await authRepository.signOut();
      emit(AuthenticationStatus.unauthenticated);
    } catch (e) {
      print('Sign out error: $e');
    }
  }
    void connected() {
    emit(AuthenticationStatus.ConnectedState);
  }

  void notConnected() {
    emit(AuthenticationStatus.NotConnectedState);
  }

  void checkConnection() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        connected();
      } else {
        notConnected();
      }
    });
  }
  
 @override
 Future<void> close() {
  _authSubscription.cancel();
  _subscription!.cancel();
  return super.close();
  }
}
