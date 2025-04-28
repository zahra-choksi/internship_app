import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/internship_job_bloc.dart';
import '../bloc/internship_job_state.dart';
import 'job_internship_list_page.dart';

class JobSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<InternshipJobBloc, InternshipJobState>(
      builder: (context, state) {
        if (state is InternshipJobLoaded ) {
          final jobs = state.jobs.where((job) {
            // Search job title and location (can be expanded)
            return job.title.toLowerCase().contains(query.toLowerCase()) ||
                job.location.toLowerCase().contains(query.toLowerCase());
          }).toList();

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return InternshipJobTile(job);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<InternshipJobBloc, InternshipJobState>(
      builder: (context, state) {
        final suggestionList = state is InternshipJobLoaded
            ? state.jobs.where((job) {
          return job.title.toLowerCase().contains(query.toLowerCase()) ||
              job.location.toLowerCase().contains(query.toLowerCase());
        }).toList()
            : [];

        return ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            final job = suggestionList[index];
            return ListTile(
              title: Text(job.title),
              subtitle: Text(job.location),
              onTap: () {
                query = job.title;
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}