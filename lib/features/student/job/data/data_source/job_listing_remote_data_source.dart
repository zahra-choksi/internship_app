// lib/features/internships/data/datasources/internship_job_remote_data_source.dart


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/internship_job.dart';
import '../model/internship_job_model.dart';

class InternshipJobRemoteDataSource {
  final FirebaseFirestore firestore;

  InternshipJobRemoteDataSource({required this.firestore});

  Future<List<InternshipJobModel>> getAllListings() async {
    final snapshot = await firestore.collection('internship_jobs').get();
    return snapshot.docs
        .map((doc) => InternshipJobModel.fromDocument(doc))
        .toList();
  }
// Future<List<InternshipJob>> searchJobs(String query) async {
//   // Fetch all jobs and filter them based on the query
//   try {

//     return allJobs.where((job) {
//       return job.title.toLowerCase().contains(query.toLowerCase()) ||
//           job.location.toLowerCase().contains(query.toLowerCase());
//     }).toList();
//   } catch (e) {
//     throw Exception('Failed to search jobs');
//   }
// }
  Future<List<InternshipJob>> searchJobs(String query) async {
    try {
      // Step 1: Fetch all jobs from Firestore
      final snapshot = await firestore.collection('internship_jobs').get();

      // Step 2: Map documents to model objects
      List<InternshipJob> allJobs = snapshot.docs
          .map((doc) => InternshipJobModel.fromDocument(doc))
          .toList();

      // Step 3: Filter jobs locally based on the search query (title and location)
      List<InternshipJob> filteredJobs = allJobs.where((job) {
        final titleMatch = job.title.toLowerCase().contains(query.toLowerCase());
        final locationMatch = job.location.toLowerCase().contains(query.toLowerCase());
        return titleMatch || locationMatch;
      }).toList();

      print("Found jobs: ${filteredJobs.length}");

      // Return the filtered list
      return filteredJobs;
    } catch (e) {
      print("Error searching jobs: $e");
      throw Exception('Failed to search jobs: $e');
    }
  }
}
