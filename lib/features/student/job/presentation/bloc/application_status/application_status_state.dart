// lib/features/application/presentation/bloc/application_status_state.dart

import '../../../domain/entity/application_status.dart';

abstract class ApplicationStatusState {}

class ApplicationStatusInitial extends ApplicationStatusState {}

class ApplicationStatusLoading extends ApplicationStatusState {}

class ApplicationStatusLoaded extends ApplicationStatusState {
  final ApplicationStatus status;

  ApplicationStatusLoaded(this.status);
}

class ApplicationStatusError extends ApplicationStatusState {
  final String message;

  ApplicationStatusError(this.message);
}
