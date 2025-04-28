// lib/features/auth/data/repositories_impl/auth_repository_impl.dart


import '../../domain/entity/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> signInWithGoogle() async {
    final firebaseUser = await remoteDataSource.signInWithGoogle();
    if (firebaseUser == null) {
      throw Exception('Google Sign In Failed');
    }
    return UserModel.fromFirebase(firebaseUser);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    final firebaseUser = remoteDataSource.getCurrentUser();
    if (firebaseUser == null) return null;
    return UserModel.fromFirebase(firebaseUser);
  }
}
