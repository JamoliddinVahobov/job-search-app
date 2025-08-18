import 'package:job_search_app/features/job/model/params/get_jobs_params.dart';
import 'package:job_search_app/features/job/model/models/paginated_jobs_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:job_search_app/core/error/get_error_message.dart';

class JobDataSource {
  final Dio dio;

  const JobDataSource(this.dio);

  Future<PaginatedJobsModel> getJobs(GetJobsParams params) async {
    try {
      final response = await dio.get(
        'jobs/gb/search/${params.page}',
        queryParameters: params.toQueryParams(),
      );

      return PaginatedJobsModel.fromJson(response.data);
    } on DioException catch (e, s) {
      debugPrint('error data: ${e.response?.data} \n stacktrace: $s');
      throw getErrorMessage(e);
    } catch (e, s) {
      debugPrint('non-dio error: $e \n stacktrace: $s');
      throw getErrorMessage(e);
    }
  }
}
