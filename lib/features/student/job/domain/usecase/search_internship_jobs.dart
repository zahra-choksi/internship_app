// lib/features/internships/domain/usecase/search_internship_jobs.dart


import '../entity/internship_job.dart';
import '../repository/internship_job_repository.dart';

// class SearchInternshipJobs {
//   final InternshipJobRepository repository;
//
//   SearchInternshipJobs({required this.repository});
//
//   Future<List<InternshipJob>> call(String query) async {
//     return await repository.searchInternshipJobs(query);
//   }
// }
// // lib/features/job/domain/usecase/search_internship_jobs.dart
//
// import '../repository/internship_job_repository.dart';
// import '../entity/internship_job.dart';

class SearchInternshipJobs {
  final InternshipJobRepository repository;

  SearchInternshipJobs({required this.repository});

  // Returns a list of jobs matching the search query
  Future<List<InternshipJob>> call(String query) async {
    return await repository.searchInternshipJobs(query);
  }
}
