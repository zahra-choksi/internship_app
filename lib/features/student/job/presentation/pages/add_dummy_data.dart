// lib/features/internships/presentation/pages/add_dummy_data_page.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDummyDataPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addDummyData() async {
    await firestore.collection('internship_jobs').add({
      'title': 'Backend Developer Intern',
      'description': 'Work on Node.js and API development.',
      'location': 'Bangalore',
      'stipendOrSalary': '8000 INR/month',
      'eligibility': 'B.Tech / MCA students',
      'lastDate': DateTime.now().add(Duration(days: 30)),
      'isInternship': true,
    });

    await firestore.collection('internship_jobs').add({
      'title': 'Software Engineer (Full Time)',
      'description': 'Looking for passionate full-stack engineers.',
      'location': 'Hyderabad',
      'stipendOrSalary': '12 LPA',
      'eligibility': '2024 graduates',
      'lastDate': DateTime.now().add(Duration(days: 60)),
      'isInternship': false,
    });


  await firestore.collection('internship_jobs').add({
  'title': 'Flutter Developer(part-time)',
  'description': 'Looking for passionate  engineer.',
  'location': 'Kolkata',
  'stipendOrSalary': '1 LPA',
  'eligibility': 'bsc cs /CSE',
  'lastDate': DateTime.now().add(Duration(days: 60)),
  'isInternship': false,
  });

    await firestore.collection('internship_jobs').add({
      'title': 'Frontent Developer(full-time)',
      'description': 'Looking for passionate full-stack engineers.',
      'location': 'rajkot',
      'stipendOrSalary': '10 LPA',
      'eligibility': 'bsc cs /CSE/B TECH',
      'lastDate': DateTime.now().add(Duration(days: 60)),
      'isInternship': false,
    });

    await firestore.collection('internship_jobs').add({
      'title': 'Frontent Developer(part-time)',
      'description': 'Looking for passionate full-stack engineers.',
      'location': 'surat',
      'stipendOrSalary': '10 LPA',
      'eligibility': 'bsc cs /CSE/B TECH',
      'lastDate': DateTime.now().add(Duration(days: 60)),
      'isInternship': true,
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Dummy Data')),
      body: Center(
        child: ElevatedButton(
          onPressed: addDummyData,
          child: Text('Add Dummy Jobs'),
        ),
      ),
    );
  }
}
