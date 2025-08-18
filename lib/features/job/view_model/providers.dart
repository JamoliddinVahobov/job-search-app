import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/features/job/view_model/job_notifier.dart';

final jobProvider = NotifierProvider<JobNotifier, JobState>(
  () => JobNotifier(),
);
