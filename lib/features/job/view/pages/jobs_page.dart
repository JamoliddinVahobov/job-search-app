import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/core/extensions/page_status_x.dart';
import 'package:job_search_app/features/job/view_model/job_notifier_provider.dart';

class JobsPage extends ConsumerStatefulWidget {
  const JobsPage({super.key});

  @override
  ConsumerState<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends ConsumerState<JobsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(jobNotifierProvider.notifier).getJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Jobs')),

      body: Builder(
        builder: (_) {
          final state = ref.watch(jobNotifierProvider);

          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.status.isError) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Something went wrong.',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state.status.isSuccess) {
            if (state.jobs.isEmpty) {
              return const Center(child: Text('No jobs found.'));
            } else {
              return ListView.builder(
                itemCount: state.jobs.length,
                itemBuilder: (context, index) {
                  final job = state.jobs[index];
                  return ListTile(
                    title: Text(job.title),
                    subtitle: Text(job.title),
                  );
                },
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
