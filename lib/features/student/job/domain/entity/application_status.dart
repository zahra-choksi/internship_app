// lib/domain/entity/application_status.dart
class ApplicationStatus {
  final String jobId;
  final String status;  // E.g., "Pending", "Accepted", "Rejected"
  final DateTime appliedOn;

  ApplicationStatus({
    required this.jobId,
    required this.status,
    required this.appliedOn,
  });
}
