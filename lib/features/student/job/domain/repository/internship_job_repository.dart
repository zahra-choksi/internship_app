// lib/features/internships/domain/repositories/internship_job_repository.dart

import '../entity/internship_job.dart';

abstract class InternshipJobRepository {
  Future<List<InternshipJob>> getAllListings();
  Future<List<InternshipJob>> searchInternshipJobs(String query);
}
