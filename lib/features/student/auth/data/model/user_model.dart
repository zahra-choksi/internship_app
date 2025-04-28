import '../../domain/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserModel extends User {
  UserModel({
    required String uid,
    required String email,
    required String name,
    required String photoUrl,
  }) : super(uid: uid, email: email, name: name, photoUrl: photoUrl);

  factory UserModel.fromFirebase(firebase_auth.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }
}
