import 'package:job_search_app/features/job/data/params/get_jobs_params.dart';
import 'package:job_search_app/features/job/model/paginated_jobs_model.dart';

abstract class JobDataSource {
  const JobDataSource();

  Future<PaginatedJobsModel> getJobs(GetJobsParams params);
}
