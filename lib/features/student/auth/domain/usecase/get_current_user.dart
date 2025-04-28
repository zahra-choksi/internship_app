// lib/features/auth/domain/usecases/get_current_user.dart

import '../entity/user.dart';
import '../repository/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<User?> call() async {
    return await repository.getCurrentUser();
  }
}
