// lib/domain/repository/application_status_repository.dart
import '../entity/application_status.dart';

abstract class ApplicationStatusRepository {
  Future<ApplicationStatus> getApplicationStatus(String jobId);
}
