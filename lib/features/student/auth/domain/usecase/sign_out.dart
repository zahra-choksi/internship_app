// lib/features/auth/domain/usecases/sign_out.dart

import '../repository/auth_repository.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}
