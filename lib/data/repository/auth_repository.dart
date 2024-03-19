

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marvel/data/models/user_model.dart';
abstract class AuthRepository {
  Future<UserModel?> signUp({required String email, required String password, });
  Future<UserModel?> signIn({required String email, required String password});
  Future<void> signOut();

  
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
   Future<UserModel?> signUp({required String email, required String password, }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user;
      
         return UserModel(
            userId: userCredential.user!.uid,
            email: userCredential.user!.email!,
            
            image: userCredential.user!.photoURL,
      );
    } catch (e) {
      debugPrint('Error signing up: $e');
      return null;
    }
  }
  @override
  Future<UserModel?> signIn({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
       print('${userCredential.user!.uid},${userCredential.user!.email!},${userCredential.user!.displayName}');
      return UserModel(
        userId: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userCredential.user!.displayName,
        image: userCredential.user!.photoURL,
      );
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
  
}