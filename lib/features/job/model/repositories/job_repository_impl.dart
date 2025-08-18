import 'package:dartz/dartz.dart';
import 'package:job_search_app/core/error/failure.dart';
import 'package:job_search_app/core/utils/utils.dart';
import 'package:job_search_app/features/job/model/params/get_jobs_params.dart';
import 'package:job_search_app/features/job/model/data_sources/job_data_source.dart';
import 'package:job_search_app/features/job/model/repositories/job_repository.dart';
import 'package:job_search_app/features/job/model/models/paginated_jobs_model.dart';

class JobRepositoryImpl implements JobRepository {
  final JobDataSource _dataSource;

  JobRepositoryImpl(this._dataSource);

  @override
  FutureResult<PaginatedJobsModel> getJobs(GetJobsParams params) async {
    try {
      final model = await _dataSource.getJobs(params);
      return Right(model);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
