// lib/domain/usecase/apply_for_job.dart
import '../entity/job_application.dart';
import '../repository/job_application_repository.dart';

class ApplyForJob {
  final JobApplicationRepository repository;

  ApplyForJob(this.repository);

  Future<void> call(JobApplication application) async {
    return await repository.applyForJob(application);
  }
}
