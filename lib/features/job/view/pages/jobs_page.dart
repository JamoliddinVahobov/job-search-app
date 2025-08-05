import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/core/extensions/extensions.dart';
import 'package:job_search_app/core/utils/utils.dart';
import 'package:job_search_app/core/widgets/custom_empty_widget.dart';
import 'package:job_search_app/core/widgets/custom_error_widget.dart';
import 'package:job_search_app/core/widgets/fields/main_search_field.dart';
import 'package:job_search_app/features/job/view/widgets/job_card.dart';
import 'package:job_search_app/features/job/view_model/job_notifier_provider.dart';

class JobsPage extends ConsumerStatefulWidget {
  const JobsPage({super.key});

  @override
  ConsumerState<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends ConsumerState<JobsPage> {
  final TextEditingController _searchController = TextEditingController();
  late final ScrollController _scrollController;

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
      appBar: AppBar(
        title: const Text('Browse Jobs'),
        centerTitle: true,
        forceMaterialTransparency: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(46),
          child: Padding(
            padding: searchFieldPadding,
            child: MainSearchField(
              hintText: 'Search jobs',
              controller: _searchController,
              onChanged: (String value) {
                Debouncer.debounce(() => _getJobs(searchTerm: value));
              },
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (_) {
          final state = ref.watch(jobProvider);
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.status.isError) {
            return CustomErrorWidget(onTap: () => _getJobs());
          } else if (state.status.isSuccess) {
            if (state.jobs.isEmpty) {
              return CustomEmptyWidget();
            } else {
              return RefreshIndicator.adaptive(
                onRefresh: () async => _getJobs(),
                child: ListView.separated(
                  controller: _scrollController,
                  padding: paddingHor12Ver4,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount:
                      state.jobs.length + (state.isPaginationLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < state.jobs.length) {
                      final job = state.jobs[index];
                      return JobCard(job: job);
                    } else {
                      return const Padding(
                        padding: paddingVer14,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) => h6,
                ),
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton:
          ref.watch(jobProvider).status.isSuccess &&
              _scrollController.hasClients &&
              _scrollController.offset > 0
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.jumpTo(0);
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
