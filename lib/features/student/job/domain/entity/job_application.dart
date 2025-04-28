// lib/domain/entity/job_application.dart
class JobApplication {
  final String jobId;
  final String applicantName;
  final String applicantEmail;
  final String resumeUrl;

  JobApplication({
    required this.jobId,
    required this.applicantName,
    required this.applicantEmail,
    required this.resumeUrl,
  });
}
