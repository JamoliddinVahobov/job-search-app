part of 'job_notifier.dart';

class JobState extends Equatable {
  final PageStatus status;
  final bool isPaginationLoading;
  final int lastFetchedPage;
  final String? errorMessage;
  final int? count;
  final num? mean;
  final List<JobModel> jobs;
  final bool showScrollToTop;

  const JobState({
    this.status = PageStatus.loading,
    this.isPaginationLoading = false,
    this.lastFetchedPage = 1,
    this.errorMessage,
    this.count,
    this.mean,
    this.jobs = const [],
    this.showScrollToTop = false,
  });

  JobState copyWith({
    PageStatus? status,
    bool? isPaginationLoading,
    int? lastFetchedPage,
    String? errorMessage,
    int? count,
    num? mean,
    List<JobModel>? jobs,
    bool? showScrollToTop,
  }) {
    return JobState(
      status: status ?? this.status,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      lastFetchedPage: lastFetchedPage ?? this.lastFetchedPage,
      errorMessage: errorMessage ?? this.errorMessage,
      count: count ?? this.count,
      mean: mean ?? this.mean,
      jobs: jobs ?? this.jobs,
      showScrollToTop: showScrollToTop ?? this.showScrollToTop,
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
    showScrollToTop,
  ];
}
