import 'package:flutter/material.dart';
import 'package:job_search_app/core/utils/all_utils.dart';
import 'package:job_search_app/features/job/model/paginated_jobs_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JobCard extends StatelessWidget {
  final JobModel job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              job.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              '${job.company.companyName} • ${job.location.displayName}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            if (job.salaryMin != null && job.salaryMax != null)
              Text(
                '${job.salaryMin!.toStringAsFixed(0)} - ${job.salaryMax!.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              job.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
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
                child: const Text('Apply on Adnuza'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
