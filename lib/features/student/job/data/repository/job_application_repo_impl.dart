// lib/features/internships/data/repository/job_application_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/job_application.dart';
import '../../domain/entity/job_application.dart';
import '../../domain/repository/job_application_repository.dart';

class JobApplicationRepositoryImpl implements JobApplicationRepository {
  final FirebaseFirestore firestore;

  JobApplicationRepositoryImpl({required this.firestore});

  @override
  Future<void> applyForJob(JobApplication application) async {
    try {
      await firestore.collection('job_applications').add({
        'jobId': application.jobId,
        'applicantName': application.applicantName,
        'applicantEmail': application.applicantEmail,
        'resumeUrl': application.resumeUrl,
      });
    } catch (e) {
      throw Exception('Failed to apply for job: $e');
    }
  }
}
