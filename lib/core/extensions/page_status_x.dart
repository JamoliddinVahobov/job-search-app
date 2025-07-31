part of 'extensions.dart';

extension PageStatusX on PageStatus {
  bool get isLoading => this == PageStatus.loading;
  bool get isSuccess => this == PageStatus.success;
  bool get isError => this == PageStatus.error;
}
