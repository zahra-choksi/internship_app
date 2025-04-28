
import '../entity/user.dart';
import '../repository/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<User> call() async {
    return await repository.signInWithGoogle();
  }
}
