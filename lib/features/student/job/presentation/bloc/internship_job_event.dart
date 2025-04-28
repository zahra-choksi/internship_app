// lib/features/internships/presentation/bloc/internship_job_event.dart

abstract class InternshipJobEvent {}

class LoadInternshipJobsEvent extends InternshipJobEvent {}

class ToggleBookmarkEvent extends InternshipJobEvent {
   final String jobId;
   ToggleBookmarkEvent({required this.jobId});
}

class SearchInternshipJobsEvent extends InternshipJobEvent {
   final String query;

   SearchInternshipJobsEvent({required this.query});
}

class ApplyForJobEvent extends InternshipJobEvent {
   final String jobId;
   final String applicantName;
   final String applicantEmail;
   final String resumeUrl;

   ApplyForJobEvent({
      required this.jobId,
      required this.applicantName,
      required this.applicantEmail,
      required this.resumeUrl,
   });
}
