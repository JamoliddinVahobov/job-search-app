part of 'job_notifier.dart';

class JobState extends Equatable {
  final PageStatus status;
  final String? errorMessage;
  final int? count;
  final num? mean;
  final List<JobModel> jobs;

  const JobState({
    this.status = PageStatus.loading,
    this.errorMessage,
    this.count,
    this.mean,
    this.jobs = const [],
  });

  JobState copyWith({
    PageStatus? status,
    String? errorMessage,
    int? count,
    num? mean,
    List<JobModel>? jobs,
  }) {
    return JobState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      count: count ?? this.count,
      mean: mean ?? this.mean,
      jobs: jobs ?? this.jobs,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, count, mean, jobs];
}
