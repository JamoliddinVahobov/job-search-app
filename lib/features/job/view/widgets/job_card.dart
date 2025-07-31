import 'package:flutter/material.dart';
import 'package:job_search_app/core/utils/all_utils.dart';
import 'package:job_search_app/features/job/model/all_jobs_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius12),

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.title, style: Theme.of(context).textTheme.titleMedium),
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
            // const SizedBox(height: 8),
            // Apply / View button
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () {
            //       launchUrl(Uri.parse(job.redirectUrl));
            //     },
            //     child: const Text('View Job'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
