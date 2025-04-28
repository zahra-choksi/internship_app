// lib/features/application/presentation/bloc/application_status_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/application_status_usecase.dart';
import 'application_status_event.dart';
import 'application_status_state.dart';

class ApplicationStatusBloc
    extends Bloc<ApplicationStatusEvent, ApplicationStatusState> {
  final GetApplicationStatus getApplicationStatus;

  ApplicationStatusBloc(this.getApplicationStatus)
      : super(ApplicationStatusInitial());

  @override
  Stream<ApplicationStatusState> mapEventToState(
      ApplicationStatusEvent event) async* {
    if (event is FetchApplicationStatusEvent) {
      yield ApplicationStatusLoading();

      try {
        final status = await getApplicationStatus(event.jobId);
        yield ApplicationStatusLoaded(status);
      } catch (e) {
        yield ApplicationStatusError(e.toString());
      }
    }
  }
}
