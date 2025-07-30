import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/core/providers/dio_provider.dart';
import 'package:job_search_app/features/job/data/job_data_source.dart';
import 'package:job_search_app/features/job/data/job_repository.dart';

final jobDataSourceProvider = Provider<JobDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return JobDataSource(dio);
});

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final dataSource = ref.read(jobDataSourceProvider);
  return JobRepository(dataSource);
});
