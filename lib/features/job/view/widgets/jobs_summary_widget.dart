import 'package:flutter/material.dart';
import 'package:job_search_app/core/extensions/build_context_x.dart';
import 'package:job_search_app/core/utils/utils.dart';

class JobsSummaryWidget extends StatelessWidget {
  final num? count;
  final num? mean;

  const JobsSummaryWidget({super.key, this.count, this.mean});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Jobs count: ',
                style: context.textStyle.bodySmall,
              ),
              TextSpan(
                text: "${count?.toString()}",
                style: context.textStyle.bodyMedium?.copyWith(
                  color: context.color.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Average salary: ',
                style: context.textStyle.bodySmall,
              ),
              TextSpan(
                text: '£ ${formatMoney(mean)}',
                style: context.textStyle.bodyMedium?.copyWith(
                  color: context.color.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
