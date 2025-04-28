// lib/features/application/data/repositories/application_status_repository_impl.dart


import '../../domain/entity/application_status.dart';
import '../../domain/repository/application_status_repository.dart';
import '../data_source/application_re,ote_data_source.dart';

class ApplicationStatusRepositoryImpl implements ApplicationStatusRepository {
  final ApplicationStatusRemoteDataSource remoteDataSource;

  ApplicationStatusRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApplicationStatus> getApplicationStatus(String jobId) {
    return remoteDataSource.getApplicationStatus(jobId);
  }
}
