import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/core/providers/dio_provider.dart';
import 'package:job_search_app/features/job/data/data_source/job_data_source.dart';
import 'package:job_search_app/features/job/data/data_source/job_data_source_impl.dart';
import 'package:job_search_app/features/job/data/repository/job_repository.dart';
import 'package:job_search_app/features/job/data/repository/job_repository_impl.dart';

final jobDataSourceProvider = Provider<JobDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return JobDataSourceImpl(dio);
});

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final dataSource = ref.read(jobDataSourceProvider);
  return JobRepositoryImpl(dataSource);
});
