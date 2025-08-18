import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_search_app/core/extensions/build_context_x.dart';
import 'package:job_search_app/core/utils/utils.dart';
import 'package:job_search_app/features/job/model/models/paginated_jobs_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JobCard extends StatelessWidget {
  final JobModel job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: borderRadius10),
      color: context.color.surfaceContainerLow,
      child: Padding(
        padding: paddingHor16Ver12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: context.textStyle.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.color.onPrimaryContainer,
                          fontSize: 20,
                        ),
                      ),
                      h2,

                      Row(
                        children: [
                          Icon(
                            Icons.business_outlined,
                            size: 18,
                            color: context.color.onSecondaryContainer,
                          ),
                          w4,
                          Expanded(
                            child: Text(
                              job.company?.companyName ?? 'Unknown Company',
                              style: context.textStyle.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.color.onSecondaryContainer,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      h2,
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: context.color.onSecondaryContainer,
                          ),
                          w4,
                          Expanded(
                            child: Text(
                              job.location?.displayName ?? '',
                              style: context.textStyle.bodySmall?.copyWith(
                                color: context.color.onSecondaryContainer,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Text(
                  _getTimeAgo(job.created),
                  style: context.textStyle.bodySmall?.copyWith(
                    color: context.color.secondary,
                  ),
                ),
              ],
            ),
            h6,
            Container(
              padding: paddingHor12Ver4,
              decoration: BoxDecoration(
                borderRadius: borderRadius16,
                border: Border.all(
                  color: context.color.primary.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                "£ ${formatMoney(job.salaryMin)} - ${formatMoney(job.salaryMax)}",
                style: context.textStyle.bodyMedium?.copyWith(
                  color: context.color.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            h6,

            if (job.description != null && job.description!.isNotEmpty) ...[
              Text(
                job.description!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.textStyle.bodySmall?.copyWith(
                  height: 1.4,
                  color: context.color.onPrimaryContainer,
                ),
              ),
              h6,
            ],

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (job.category != null) ...[
                  Text(
                    job.category!.label,
                    style: context.textStyle.bodySmall?.copyWith(
                      color: context.color.tertiary,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                ElevatedButton.icon(
                  onPressed: () {
                    try {
                      launchUrlString(
                        job.redirectUrl,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e, s) {
                      debugPrint('$e, $s');
                    }
                  },
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Apply'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.color.primary,
                    foregroundColor: context.color.surfaceContainerLowest,
                    padding: paddingHor20Ver4,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(String created) {
    try {
      final createdDate = DateTime.parse(created);
      final now = DateTime.now();
      final difference = now.difference(createdDate);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inSeconds > 0) {
        return 'Just now';
      } else {
        return DateFormat('dd.MM.yyyy').format(createdDate);
      }
    } catch (e) {
      return '';
    }
  }
}
