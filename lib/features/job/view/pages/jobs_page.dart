import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/core/extensions/extensions.dart';
import 'package:job_search_app/core/utils/utils.dart';
import 'package:job_search_app/core/widgets/page_status_widgets/custom_empty_widget.dart';
import 'package:job_search_app/core/widgets/page_status_widgets/custom_error_widget.dart';
import 'package:job_search_app/core/widgets/fields/main_search_field.dart';
import 'package:job_search_app/features/job/view/widgets/job_card.dart';
import 'package:job_search_app/features/job/view/widgets/jobs_summary_widget.dart';
import 'package:job_search_app/features/job/view_model/job_notifier_provider.dart';

class JobsPage extends ConsumerStatefulWidget {
  const JobsPage({super.key});

  @override
  ConsumerState<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends ConsumerState<JobsPage> {
  final TextEditingController _searchController = TextEditingController();
  late final ScrollController _scrollController;
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _getJobs();
    });
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    Debouncer.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final shouldShow = _scrollController.offset > 200;
    if (shouldShow != _showScrollToTop) {
      setState(() {
        _showScrollToTop = shouldShow;
      });
    }

    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(jobProvider);

      final hasMore = state.jobs.length < state.count!;
      final isLoading = state.isPaginationLoading;

      if (hasMore && !isLoading) {
        final newPage = state.lastFetchedPage + 1;
        _getJobs(page: newPage);
      }
    }
  }

  void _getJobs({int page = 1, String? searchTerm}) {
    ref
        .read(jobProvider.notifier)
        .getJobs(
          page: page,
          searchTerm: searchTerm?.trim() ?? _searchController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(jobProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        showErrorSnackBar(context, next.errorMessage!);
      }
    });

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            left: false,
            right: false,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 6),
              child: MainSearchField(
                hintText: 'Search jobs',
                controller: _searchController,
                onChanged: (String value) {
                  Debouncer.debounce(() => _getJobs(searchTerm: value));
                },
                clearOnTap: () {
                  Debouncer.debounce(() => _getJobs(searchTerm: ''));
                },
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                final state = ref.watch(jobProvider);
                if (state.status.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state.status.isError) {
                  return CustomErrorWidget(onTap: () => _getJobs());
                } else if (state.status.isSuccess) {
                  if (state.jobs.isEmpty) {
                    return CustomEmptyWidget();
                  } else {
                    return RefreshIndicator.adaptive(
                      onRefresh: () async => _getJobs(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                            child: JobsSummaryWidget(
                              count: state.count,
                              mean: state.mean,
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              controller: _scrollController,
                              padding: paddingHor12Ver4,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount:
                                  state.jobs.length +
                                  (state.isPaginationLoading ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index < state.jobs.length) {
                                  final job = state.jobs[index];
                                  return JobCard(job: job);
                                } else {
                                  return const Padding(
                                    padding: paddingVer14,
                                    child: Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  );
                                }
                              },
                              separatorBuilder: (context, index) => h6,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton:
          ref.watch(jobProvider).status.isSuccess && _showScrollToTop
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
