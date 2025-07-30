import 'package:job_search_app/core/utils/all_utils.dart';

class GetJobsParams {
  final String searchTerm;

  GetJobsParams({this.searchTerm = ''});

  MapData toQueryParams() => {'what': searchTerm};
}
