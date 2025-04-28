// lib/features/job/presentation/pages/saved_job_page.dart

import 'package:flutter/material.dart';
import 'package:internship/features/student/job/domain/entity/job_application.dart';
import '../../domain/entity/internship_job.dart';
import '../bloc/internship_job_bloc.dart';
import '../bloc/internship_job_state.dart';
import 'detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedJobsPage extends StatelessWidget {
  final JobApplication? application;
  SavedJobsPage({this.application});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Jobs'),
      ),
      body: BlocBuilder<InternshipJobBloc, InternshipJobState>(
        builder: (context, state) {
          if (state is InternshipJobLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InternshipJobLoaded) {
            final savedJobs = state.jobs.where((job) => job.isBookmarked == true).toList();
            return ListView.builder(
              itemCount: savedJobs.length,
              itemBuilder: (context, index) {
                final job = savedJobs[index];
                return ListTile(
                  title: Text(job.title),
                  subtitle: Text(job.location),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InternshipJobDetailPage(
                            job:  job,
                          application: application,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is InternshipJobError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
