part of 'job_notifier.dart';

class JobState extends Equatable {
  final PageStatus status;
  final bool isPaginationLoading;
  final int lastFetchedPage;
  final String? errorMessage;
  final int? count;
  final num? mean;
  final List<JobModel> jobs;

  const JobState({
    this.status = PageStatus.loading,
    this.isPaginationLoading = false,
    this.lastFetchedPage = 1,
    this.errorMessage,
    this.count,
    this.mean,
    this.jobs = const [],
  });

  JobState copyWith({
    PageStatus? status,
    bool? isPaginationLoading,
    int? lastFetchedPage,
    String? errorMessage,
    int? count,
    num? mean,
    List<JobModel>? jobs,
  }) {
    return JobState(
      status: status ?? this.status,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      lastFetchedPage: lastFetchedPage ?? this.lastFetchedPage,
      errorMessage: errorMessage ?? this.errorMessage,
      count: count ?? this.count,
      mean: mean ?? this.mean,
      jobs: jobs ?? this.jobs,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isPaginationLoading,
    lastFetchedPage,
    errorMessage,
    count,
    mean,
    jobs,
  ];
}
