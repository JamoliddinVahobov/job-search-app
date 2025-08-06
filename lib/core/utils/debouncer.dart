part of 'utils.dart';

class Debouncer {
  static Timer? timer;

  static void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }

    timer = Timer(duration, callback);
  }

  static void dispose() {
    timer?.cancel();
    timer = null;
  }
}
