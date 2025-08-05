import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:job_search_app/features/job/data/params/get_jobs_params.dart';
import 'package:job_search_app/features/job/data/data_source/job_data_source.dart';
import 'package:job_search_app/features/job/model/paginated_jobs_model.dart';

class JobDataSourceImpl implements JobDataSource {
  final Dio dio;

  const JobDataSourceImpl(this.dio);

  @override
  Future<PaginatedJobsModel> getJobs(GetJobsParams params) async {
    try {
      final response = await dio.get(
        'jobs/gb/search/${params.page}',
        queryParameters: params.toQueryParams(),
      );

      return PaginatedJobsModel.fromJson(response.data);
    } on DioException catch (e, s) {
      debugPrint('error data: ${e.response?.data} \n stacktrace: $s');
      throw Exception(e.response?.data);
    } catch (e, s) {
      debugPrint('non-dio error: $e \n stacktrace: $s');
      throw Exception(e);
    }
  }
}
