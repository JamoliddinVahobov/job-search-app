import 'package:job_search_app/core/utils/utils.dart';
import 'package:job_search_app/features/job/model/params/get_jobs_params.dart';
import 'package:job_search_app/features/job/model/models/paginated_jobs_model.dart';

abstract class JobRepository {
  const JobRepository();

  FutureResult<PaginatedJobsModel> getJobs(GetJobsParams params);
}
