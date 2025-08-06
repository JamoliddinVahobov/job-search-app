import 'package:flutter/material.dart';
import 'package:job_search_app/core/extensions/build_context_x.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String? text;

  const CustomEmptyWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text ?? 'No data found',
            style: context.textStyle.bodyLarge?.copyWith(
              color: context.color.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
