import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internship/features/student/job/domain/entity/internship_job.dart';
import 'package:internship/features/student/job/domain/usecase/apply_for_job.dart';


import 'features/student/auth/data/datasource/auth_remote_data_source.dart';
import 'features/student/auth/data/repository/auth_repository_impl.dart';
import 'features/student/auth/domain/usecase/get_current_user.dart';
import 'features/student/auth/domain/usecase/sign_in_with_google.dart';
import 'features/student/auth/domain/usecase/sign_out.dart';
import 'features/student/auth/presentation/bloc/auth_bloc.dart';
import 'features/student/auth/presentation/bloc/auth_event.dart';
import 'features/student/auth/presentation/bloc/auth_state.dart';
import 'features/student/auth/presentation/pages/login_page.dart';
import 'features/student/job/data/data_source/application_re,ote_data_source.dart';
import 'features/student/job/data/data_source/job_listing_remote_data_source.dart';
import 'features/student/job/data/repository/application_repository_impl.dart';
import 'features/student/job/data/repository/internship_job_repository_impl.dart';
import 'features/student/job/data/repository/job_application_repo_impl.dart';
import 'features/student/job/domain/entity/application_status.dart';
import 'features/student/job/domain/usecase/application_status_usecase.dart';
import 'features/student/job/domain/usecase/get_all_internship_job.dart';
import 'features/student/job/domain/usecase/search_internship_jobs.dart';
import 'features/student/job/presentation/bloc/application_status/application_status_bloc.dart';
import 'features/student/job/presentation/bloc/internship_job_bloc.dart';
import 'features/student/job/presentation/bloc/internship_job_event.dart';
import 'features/student/job/presentation/pages/application_status_page.dart';
import 'features/student/job/presentation/pages/job_internship_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final authRemoteDataSource = AuthRemoteDataSource(
    firebaseAuth: firebaseAuth,
    googleSignIn: googleSignIn,
  );
  final authRepository = AuthRepositoryImpl(authRemoteDataSource);
  //remote data source
  final remoteDataSource = InternshipJobRemoteDataSource(firestore: firestore);
  // repository
  final internshipJobRepository = IntershipJobRepositoryImpl(remoteDataSource,
  );
  final repository = JobApplicationRepositoryImpl(firestore: firestore);
 //usecase
  final  getAllInternshipJobs = GetAllInternshipJobs(
    internshipJobRepository,
  );

  final searchInternshipJobs = SearchInternshipJobs(
      repository: internshipJobRepository);
  final applyForInternship = ApplyForJob(
    repository
  );

  runApp(MyApp(
    authRepository: authRepository,
    getAllInternshipJobs: getAllInternshipJobs,
    searchInternshipJobs: searchInternshipJobs,
    applyForJob: applyForInternship,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final GetAllInternshipJobs getAllInternshipJobs;
  final SearchInternshipJobs searchInternshipJobs;
  final ApplyForJob applyForJob;
  const MyApp({
    Key? key, 
    required this.authRepository,
    required this.getAllInternshipJobs,
    required this.searchInternshipJobs,
    required this.applyForJob
  }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          AuthBloc(
            signInWithGoogle: SignInWithGoogle(authRepository),
            signOut: SignOut(authRepository),
            getCurrentUser: GetCurrentUser(authRepository),
          )
            ..add(
                CheckAuthStatusEvent()), // Automatically check if user already logged in
        ),
        BlocProvider<InternshipJobBloc>(
          create: (_) => InternshipJobBloc(
            getAllInternshipJobs: getAllInternshipJobs,
            searchInternshipJobs: searchInternshipJobs,
            applyForJob: applyForJob,
          )..add(LoadInternshipJobsEvent()),
        ),
        BlocProvider(
          create: (context) => ApplicationStatusBloc(
            GetApplicationStatus(
              ApplicationStatusRepositoryImpl(
                ApplicationStatusRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Internship App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final InternshipJob? job;
  AuthWrapper({ this.job});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial || state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is Authenticated) {
          return HomePage(job: job,); // 👈 Create a dummy HomePage
        } else {
          return LoginPage();
        }
      },
    );
  }
}

// Dummy HomePage after login
class HomePage extends StatelessWidget {
  final InternshipJob? job;
  HomePage({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Logged In)'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignOutEvent());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
       child: ElevatedButton(
         onPressed: () {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (_) => InternshipJobListPage()),
           );
         },
         child: const Text('View Internship Jobs'),
       ),
              ),


    );
  }
}
