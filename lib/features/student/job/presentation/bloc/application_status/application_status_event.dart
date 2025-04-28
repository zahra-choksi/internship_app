// lib/features/application/presentation/bloc/application_status_event.dart
abstract class ApplicationStatusEvent {}

class FetchApplicationStatusEvent extends ApplicationStatusEvent {
  final String jobId;

  FetchApplicationStatusEvent(this.jobId);
}
