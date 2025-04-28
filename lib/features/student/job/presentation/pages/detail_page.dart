// lib/features/internships/presentation/pages/internship_job_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/features/student/job/domain/entity/job_application.dart';
import 'package:internship/features/student/job/domain/usecase/apply_for_job.dart';
import '../../domain/entity/internship_job.dart';
import '../bloc/internship_job_bloc.dart';
import '../bloc/internship_job_event.dart';
import 'job_apply_screen.dart';

class InternshipJobDetailPage extends StatelessWidget {
  final InternshipJob job;
  final JobApplication? application;
  const InternshipJobDetailPage({
    required this.job,
    this.application
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${job.location} • Last Date: ${job.lastDate.toLocal().toString().split(' ')[0]}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              job.description,  // Assuming you have a description field in your model
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> InternshipJobApplyScreen(job: job,)));
              },
              child: const Text('Apply'),
            ),
            SizedBox(height: 16),
            IconButton(
              icon: Icon(
                (job.isBookmarked ?? false) ? Icons.bookmark : Icons.bookmark_border,
                color: (job.isBookmarked ?? false) ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                // Toggle bookmark event
                context.read<InternshipJobBloc>().add(ToggleBookmarkEvent(jobId: job.id));
              },
            ),
          ],
        ),
      ),
    );
  }
}
