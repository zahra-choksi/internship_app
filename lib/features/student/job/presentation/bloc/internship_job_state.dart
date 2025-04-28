// lib/features/internships/presentation/bloc/internship_job_state.dart

import '../../domain/entity/internship_job.dart';
import '../../domain/entity/job_application.dart';

abstract class InternshipJobState {}

class InternshipJobInitial extends InternshipJobState {}

class InternshipJobLoading extends InternshipJobState {}

class InternshipJobLoaded extends InternshipJobState {
  final List<InternshipJob> jobs;

  InternshipJobLoaded(this.jobs);
}

class InternshipJobError extends InternshipJobState {
  final String message;

  InternshipJobError(this.message);
}

class InternshipJobSearchResults extends InternshipJobState {
  final List<InternshipJob> jobs;

  InternshipJobSearchResults(this.jobs);
}

class InternshipJobApplied extends InternshipJobState{

}