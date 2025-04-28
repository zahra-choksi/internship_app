// lib/domain/usecase/get_application_status.dart

import '../entity/application_status.dart';
import '../repository/application_status_repository.dart';

class GetApplicationStatus {
  final ApplicationStatusRepository repository;

  GetApplicationStatus(this.repository);

  Future<ApplicationStatus> call(String jobId) {
    return repository.getApplicationStatus(jobId);
  }
}
