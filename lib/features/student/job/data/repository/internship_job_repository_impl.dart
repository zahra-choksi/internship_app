// // lib/features/auth/data/repositories_impl/auth_repository_impl.dart
//
//
// import '../../domain/entity/user.dart';
// import '../../domain/repository/auth_repository.dart';
// import '../datasource/auth_remote_data_source.dart';
// import '../model/user_model.dart';
//
// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource remoteDataSource;
//
//   AuthRepositoryImpl(this.remoteDataSource);
//
//   @override
//   Future<User> signInWithGoogle() async {
//     final firebaseUser = await remoteDataSource.signInWithGoogle();
//     if (firebaseUser == null) {
//       throw Exception('Google Sign In Failed');
//     }
//     return UserModel.fromFirebase(firebaseUser);
//   }
//
//   @override
//   Future<void> signOut() async {
//     await remoteDataSource.signOut();
//   }
//
//   @override
//   Future<User?> getCurrentUser() async {
//     final firebaseUser = remoteDataSource.getCurrentUser();
//     if (firebaseUser == null) return null;
//     return UserModel.fromFirebase(firebaseUser);
//   }
// }

import '../../domain/entity/internship_job.dart';
import '../../domain/repository/internship_job_repository.dart';
import '../data_source/job_listing_remote_data_source.dart';

class IntershipJobRepositoryImpl implements InternshipJobRepository{
  final InternshipJobRemoteDataSource remoteDataSource;
  IntershipJobRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<InternshipJob>> getAllListings() async{
    return await remoteDataSource.getAllListings();
  }
  // @override
  // Future<List<InternshipJob>> searchInternshipJobs(String query) async {
  //   try {
  //     return await remoteDataSource.searchJobs(query);
  //   } catch (e) {
  //     throw Exception('Failed to search internship jobs');
  //   }
  // }
  @override

  Future<List<InternshipJob>> searchInternshipJobs(String query) async {
    return await remoteDataSource.searchJobs(query);
  }

}