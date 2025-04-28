import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/internship_job.dart';
import '../bloc/internship_job_bloc.dart';
import '../bloc/internship_job_event.dart';
import '../bloc/internship_job_state.dart';

class InternshipJobApplyScreen extends StatelessWidget {
  final InternshipJob job;

  const InternshipJobApplyScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternshipJobBloc, InternshipJobState>(
      listener: (context, state) {
        // Check for success
        if (state is InternshipJobApplied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Successfully applied for ${job.title}!'),
              backgroundColor: Colors.green,
            ),
          );
        }
        // Check for error
        if (state is InternshipJobError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to apply: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Apply for ${job.title}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Your Name'),
                // Other TextFields for email, resume, etc.
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Your Email'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Trigger the ApplyForJobEvent when applying
                  context.read<InternshipJobBloc>().add(
                    ApplyForJobEvent(
                      jobId: job.id,
                      applicantName: 'John Doe', // You can replace this with a controller value
                      applicantEmail: 'john@example.com',
                      resumeUrl: 'https://resume.com',
                    ),
                  );
                },
                child: Text('Apply'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
