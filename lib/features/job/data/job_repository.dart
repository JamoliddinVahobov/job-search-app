import 'package:dartz/dartz.dart';
import 'package:job_search_app/core/error/failure.dart';
import 'package:job_search_app/core/utils/all_utils.dart';
import 'package:job_search_app/features/job/data/get_jobs_params.dart';
import 'package:job_search_app/features/job/data/job_data_source.dart';
import 'package:job_search_app/features/job/model/paginated_jobs_model.dart';

class JobRepository {
  final JobDataSource _dataSource;

  JobRepository(this._dataSource);

  FutureResult<PaginatedJobsModel> getJobs(GetJobsParams params) async {
    try {
      final model = await _dataSource.getJobs(params);
      return Right(model);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
