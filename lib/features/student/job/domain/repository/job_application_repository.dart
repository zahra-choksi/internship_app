// lib/domain/repository/job_application_repository.dart
import '../entity/job_application.dart';

abstract class JobApplicationRepository {
  Future<void> applyForJob(JobApplication application);
}
