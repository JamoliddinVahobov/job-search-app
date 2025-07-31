import 'package:job_search_app/core/constants/pagination_limits.dart';
import 'package:job_search_app/core/utils/all_utils.dart';

class GetJobsParams {
  final int page;
  final int limit;
  final String searchTerm;

  GetJobsParams({
    this.page = 1,
    this.limit = PaginationLimits.jobs,
    this.searchTerm = '',
  });

  MapData toQueryParams() => {'results_per_page': limit, 'what': searchTerm};
}
