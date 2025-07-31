import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/core/extensions/extensions.dart';
import 'package:job_search_app/core/utils/ui_helpers.dart';
import 'package:job_search_app/core/widgets/custom_empty_widget.dart';
import 'package:job_search_app/core/widgets/custom_error_widget.dart';
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
    ref.listen(jobNotifierProvider, (previous, next) {
      if (next.status.isError && next.errorMessage != null) {
        showErrorSnackBar(context, next.errorMessage!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Jobs'),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Builder(
        builder: (_) {
          final state = ref.watch(jobNotifierProvider);
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.status.isError) {
            return CustomErrorWidget(
              onTap: () => ref.read(jobNotifierProvider.notifier).getJobs(),
            );
          } else if (state.status.isSuccess) {
            if (state.jobs.isEmpty) {
              return CustomEmptyWidget();
            } else {
              return RefreshIndicator.adaptive(
                onRefresh: () async =>
                    ref.read(jobNotifierProvider.notifier).getJobs(),
                child: ListView.builder(
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    final job = state.jobs[index];
                    return ListTile(
                      title: Text(job.title),
                      subtitle: Text(job.company.companyName),
                    );
                  },
                ),
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
