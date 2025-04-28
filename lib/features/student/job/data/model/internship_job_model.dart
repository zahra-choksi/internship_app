// lib/features/internships/data/models/internship_job_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/internship_job.dart';

class InternshipJobModel extends InternshipJob {
  InternshipJobModel({
    required String id,
    required String title,
    required String description,
    required String location,
    required String stipendOrSalary,
    required String eligibility,
    required DateTime lastDate,
    required bool isInternship,
      bool? isBookmarked,
  }) : super(
    id: id,
    title: title,
    description: description,
    location: location,
    stipendOrSalary: stipendOrSalary,
    eligibility: eligibility,
    lastDate: lastDate,
    isInternship: isInternship,
    isBookmarked: isBookmarked = false,
  );

  factory InternshipJobModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InternshipJobModel(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      location: data['location'],
      stipendOrSalary: data['stipendOrSalary'],
      eligibility: data['eligibility'],
      lastDate: (data['lastDate'] as Timestamp).toDate(),
      isInternship: data['isInternship'],
      isBookmarked: data['isBookmarked']
    );
  }
  String toString() {
    return 'InternshipJobModel{id: $id, title: $title, location: $location, lastDate: $lastDate, isInternship: $isInternship}';
  }

}
