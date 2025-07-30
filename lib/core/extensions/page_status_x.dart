import 'package:job_search_app/core/enums/page_status_enum.dart';

extension PageStatusX on PageStatus {
  bool get isLoading => this == PageStatus.loading;
  bool get isSuccess => this == PageStatus.success;
  bool get isError => this == PageStatus.error;
}
