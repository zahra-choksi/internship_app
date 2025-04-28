// lib/features/internships/domain/usecases/get_all_internship_jobs.dart



import '../entity/internship_job.dart';
import '../repository/internship_job_repository.dart';

class GetAllInternshipJobs {
  final InternshipJobRepository repository;

  GetAllInternshipJobs(this.repository);

  Future<List<InternshipJob>> call() {
    return repository.getAllListings();
  }
}
