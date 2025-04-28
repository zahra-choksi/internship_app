// lib/features/internships/presentation/bloc/internship_job_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/internship_job.dart';
import '../../domain/entity/job_application.dart';
import '../../domain/usecase/apply_for_job.dart';
import '../../domain/usecase/get_all_internship_job.dart';
import '../../domain/usecase/search_internship_jobs.dart';
import 'internship_job_event.dart';
import 'internship_job_state.dart';

class InternshipJobBloc extends Bloc<InternshipJobEvent, InternshipJobState> {
  final GetAllInternshipJobs getAllInternshipJobs;
  final SearchInternshipJobs searchInternshipJobs;
  final ApplyForJob applyForJob;

  InternshipJobBloc({
    required this.getAllInternshipJobs,
    required this.searchInternshipJobs,
    required this.applyForJob
  }) : super(InternshipJobInitial()) {
    on<LoadInternshipJobsEvent>(_onLoadInternshipJobsEvent);
    on<ToggleBookmarkEvent>(_onToggleBookmarkEvent);
    on<SearchInternshipJobsEvent>(_onSearchInternshipJobsEvent);
    on<ApplyForJobEvent>(_onApplyForJobEvent);
  }
  Future<void> _onLoadInternshipJobsEvent(
      LoadInternshipJobsEvent event,
      Emitter<InternshipJobState> emit,
      ) async {
    emit(InternshipJobLoading());
    try {
      final jobs = await getAllInternshipJobs();
      emit(InternshipJobLoaded(jobs));
    } catch (e) {
      emit(InternshipJobError(e.toString()));
    }
  }

  void _onToggleBookmarkEvent(
      ToggleBookmarkEvent event,
      Emitter<InternshipJobState> emit,
      ) {
    if (state is InternshipJobLoaded) {
      final loadedState = state as InternshipJobLoaded;
      final updatedJobs = loadedState.jobs.map((job) {
        if (job.id == event.jobId) {
          // Correctly create a new InternshipJob with updated bookmark state
          return InternshipJob(
            id: job.id,
            title: job.title,
            location: job.location,
            lastDate: job.lastDate,
            isInternship: job.isInternship,
            isBookmarked: !(job.isBookmarked ?? false),
            description: job.description,
            stipendOrSalary: job.stipendOrSalary,
            eligibility: job.eligibility, // Toggle the bookmark


          );
        }
        return job;
      }).toList();
      emit(InternshipJobLoaded(updatedJobs));  // Emit updated jobs list
    }
  }
  Future<void> _onSearchInternshipJobsEvent(
      SearchInternshipJobsEvent event,
      Emitter<InternshipJobState> emit,
      ) async {
    emit(InternshipJobLoading());
    try {
      final jobs = await searchInternshipJobs(event.query);
      emit(InternshipJobSearchResults(jobs));
      print(jobs);
      print("Found jobs: ${jobs.length}");
      jobs.forEach((job) {
        print("Job title: ${job.title}, Location: ${job.location}, Last Date: ${job.lastDate}");
      });
    } catch (e) {
      emit(InternshipJobError(e.toString()));
    }
  }
  Future<void> _onApplyForJobEvent(
      ApplyForJobEvent event,
      Emitter<InternshipJobState> emit,
      ) async {
    emit(InternshipJobLoading());
    try {

     await applyForJob.call(JobApplication(
        jobId: event.jobId,
        applicantName: event.applicantName,
        applicantEmail: event.applicantEmail,
        resumeUrl: event.resumeUrl,
      ));
      emit(InternshipJobApplied());
    } catch (e) {
      emit(InternshipJobError(e.toString()));
    }
  }
}
