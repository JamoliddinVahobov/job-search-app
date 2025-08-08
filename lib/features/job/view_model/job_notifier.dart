import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:job_search_app/core/enums/page_status_enum.dart';
import 'package:job_search_app/features/job/data/params/get_jobs_params.dart';
import 'package:job_search_app/features/job/data/repository/job_repository.dart';
import 'package:job_search_app/features/job/data/providers.dart';
import 'package:job_search_app/features/job/model/paginated_jobs_model.dart';

part 'job_state.dart';

class JobNotifier extends Notifier<JobState> {
  late final JobRepository _repository;

  @override
  JobState build() {
    _repository = ref.read(jobRepositoryProvider);
    return JobState();
  }

  Future<void> getJobs({int page = 1, String? searchTerm}) async {
    final bool isInitial = page == 1;

    if (isInitial) {
      state = state.copyWith(status: PageStatus.loading);
    } else {
      state = state.copyWith(isPaginationLoading: true);
    }

    final params = GetJobsParams(page: page, searchTerm: searchTerm ?? '');

    final result = await _repository.getJobs(params);

    result.fold(
      (failure) {
        if (isInitial) {
          state = state.copyWith(
            errorMessage: failure.message,
            status: PageStatus.error,
            isPaginationLoading: false,
          );
        } else {
          state = state.copyWith(
            errorMessage: failure.message,
            isPaginationLoading: false,
          );
        }
      },
      (success) {
        List<JobModel> newList = isInitial
            ? success.jobs
            : [...state.jobs, ...success.jobs];

        state = state.copyWith(
          lastFetchedPage: page,
          count: success.count,
          mean: success.mean,
          jobs: newList,
          status: PageStatus.success,
          isPaginationLoading: false,
        );
      },
    );
  }

  void changeShowScrollToTop(bool showScrollToTop) {
    state = state.copyWith(showScrollToTop: showScrollToTop);
  }
}
