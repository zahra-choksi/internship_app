// lib/features/application/data/datasources/application_status_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/application_status.dart';

class ApplicationStatusRemoteDataSource {
  final FirebaseFirestore firestore;

  ApplicationStatusRemoteDataSource({required this.firestore});

  Future<ApplicationStatus> getApplicationStatus(String jobId) async {
    try {
      final snapshot = await firestore
          .collection('applications')
          .doc(jobId) // Assuming each job has an application status
          .get();

      if (!snapshot.exists) {
        throw Exception('Application status not found');
      }

      final data = snapshot.data();
      if (data == null) {
        throw Exception('No data found for the application status');
      }

      return ApplicationStatus(
        jobId: data['jobId'] ?? '',  // Provide a default value if it's null
        status: data['status'] ?? 'Unknown',  // Provide a default value if it's null
        appliedOn: (data['appliedOn'] as Timestamp?)?.toDate() ?? DateTime.now(),  // Ensure we have a fallback
      );
    } catch (e) {
      throw Exception('Error fetching application status: $e');
    }
  }
}
