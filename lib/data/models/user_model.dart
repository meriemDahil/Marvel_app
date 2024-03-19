import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Equatable {
  final String userId;
  final String email;
  final String? name;
  final String? image;

  const UserModel({
    required this.userId,
    required this.email,
    this.name,
    this.image,
  });

  factory UserModel.fromFirebase(UserCredential userCredential) {
   
    final firebaseUser = userCredential.user;
    return UserModel(
      userId: firebaseUser!.uid,
      email: firebaseUser.email!,
      name: firebaseUser.displayName,
      image: firebaseUser.photoURL,
    );
  }
  
  @override
  List<Object?> get props => [userId, email, name, image];

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
    );
  }
}
