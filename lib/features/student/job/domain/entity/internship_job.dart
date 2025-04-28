// lib/features/internships/domain/entities/internship_job.dart

import '../../data/model/internship_job_model.dart';

class InternshipJob {
  final String id;
  final String title;
  final String description;
  final String location;
  final String stipendOrSalary;
  final String eligibility;
  final DateTime lastDate;
  final bool isInternship;// true = internship, false = job
  final bool isBookmarked ;

  InternshipJob({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.stipendOrSalary,
    required this.eligibility,
    required this.lastDate,
    required this.isInternship,
     this.isBookmarked =false,
  });

  InternshipJobModel copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    bool? isBookmarked,
    String? stipendOrSalary,
    String? eligibility,
    bool? isInternship,
    DateTime? lastDate,
  }) {
    return InternshipJobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      stipendOrSalary: stipendOrSalary ?? this.stipendOrSalary,
      eligibility: eligibility ?? this.eligibility,
      lastDate: lastDate ?? this.lastDate,
      isInternship: isInternship ?? this.isInternship,


    );
  }
}
