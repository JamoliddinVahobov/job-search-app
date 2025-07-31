import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:job_search_app/core/enums/page_status_enum.dart';
import 'package:job_search_app/features/job/data/get_jobs_params.dart';
import 'package:job_search_app/features/job/data/job_repository.dart';
import 'package:job_search_app/features/job/data/providers.dart';
import 'package:job_search_app/features/job/model/all_jobs_model.dart';

part 'job_state.dart';

class JobNotifier extends Notifier<JobState> {
  late final JobRepository _repository;

  @override
  JobState build() {
    _repository = ref.read(jobRepositoryProvider);
    return JobState();
  }

  Future<void> getJobs({
    BuildContext? context,
    int page = 1,
    String searchTerm = '',
  }) async {
    state = state.copyWith(status: PageStatus.loading);

    final params = GetJobsParams(page: page, searchTerm: searchTerm);

    final result = await _repository.getJobs(params);

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          status: PageStatus.error,
        );
      },
      (data) {
        state = state.copyWith(
          count: data.count,
          mean: data.mean,
          jobs: data.jobs,
          status: PageStatus.success,
        );
      },
    );
  }
}
