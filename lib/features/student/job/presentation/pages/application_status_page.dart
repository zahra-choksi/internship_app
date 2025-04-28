// lib/features/application/presentation/pages/application_status_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/application_status_usecase.dart';
import '../bloc/application_status/application_status_bloc.dart';
import '../bloc/application_status/application_status_state.dart';

class ApplicationStatusPage extends StatelessWidget {
  final String jobId;

  const ApplicationStatusPage({Key? key, required this.jobId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Status'),
      ),
      body: BlocProvider(
        create: (_) => ApplicationStatusBloc(
            context.read<GetApplicationStatus>()),  // Inject GetApplicationStatus use case
        child: BlocBuilder<ApplicationStatusBloc, ApplicationStatusState>(
          builder: (context, state) {
            if (state is ApplicationStatusLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ApplicationStatusLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Job ID: ${state.status.jobId}'),
                    Text('Status: ${state.status.status}'),
                    Text('Applied on: ${state.status.appliedOn.toLocal()}'),
                  ],
                ),
              );
            } else if (state is ApplicationStatusError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
