

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/features/student/job/domain/entity/job_application.dart';
import 'package:internship/features/student/job/presentation/pages/saved_job_page.dart';

import '../../domain/entity/internship_job.dart';
import '../bloc/internship_job_bloc.dart';
import '../bloc/internship_job_event.dart';
import '../bloc/internship_job_state.dart';
import 'detail_page.dart';
import 'job_internship_list_page.dart';
import 'job_internship_list_page.dart';

class InternshipJobListPage extends StatefulWidget {
  @override
  State<InternshipJobListPage> createState() => _InternshipJobListPageState();
}

class _InternshipJobListPageState extends State<InternshipJobListPage> {
  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    context.read<InternshipJobBloc>().add(LoadInternshipJobsEvent());
  }
  void _searchJobs() {
    String query = _searchController.text.trim();
    context.read<InternshipJobBloc>().add(SearchInternshipJobsEvent(query: query));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internships & Jobs'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Navigate to saved jobs page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedJobsPage()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _searchJobs(),
              decoration: InputDecoration(
                hintText: 'Search by title or location...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),

            ),
          ),
        ),
      ),
      body: BlocBuilder<InternshipJobBloc, InternshipJobState>(
        builder: (context, state) {
          if (state is InternshipJobLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InternshipJobLoaded || state is InternshipJobSearchResults) {
            final jobs = state is InternshipJobLoaded
                ? state.jobs
                : (state is InternshipJobSearchResults ? state.jobs : []);
            return ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return InternshipJobTile( job);
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

class InternshipJobTile extends StatelessWidget {
  final InternshipJob job;
  //final JobApplication application ;
  const InternshipJobTile(
  this.job);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(job.title),
        subtitle: Text('${job.location} • Last Date: ${job.lastDate.toLocal().toString().split(' ')[0]}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            job.isInternship
                ? const Chip(
              label: Text('Internship'),
              backgroundColor: Colors.blueAccent,
              labelStyle: TextStyle(color: Colors.white),
            )
                : const Chip(
              label: Text('Job'),
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: Icon(
                  (job.isBookmarked ?? false)  // Use null-aware operator to handle null value
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: (job.isBookmarked ?? false)  // Same here for color
                      ? Colors.blue
                      : Colors.grey,
                ),

              onPressed: () {
                // Trigger the event to toggle bookmark
                context.read<InternshipJobBloc>().add(ToggleBookmarkEvent(jobId: job.id));
              },
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                // Trigger Apply for Job
                _applyForJob(context, job);
              },
            ),
          ],
        ),
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> InternshipJobDetailPage( job: job,)));
                   },

      ),
    );
  }

  }
  void _applyForJob(BuildContext context, InternshipJob job) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController emailController = TextEditingController();
        final TextEditingController resumeController = TextEditingController();

        return AlertDialog(
          title: Text('Apply for ${job.title}'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Your Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Your Email'),
              ),
              TextField(
                controller: resumeController,
                decoration: InputDecoration(labelText: 'Resume URL'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Apply'),
              onPressed: () {
                context.read<InternshipJobBloc>().add(ApplyForJobEvent(
                  jobId: job.id,
                  applicantName: nameController.text,
                  applicantEmail: emailController.text,
                  resumeUrl: resumeController.text,
                ));
              //  ScaffoldMessenger.of(context).showSnackBar()
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

