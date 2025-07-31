import 'package:flutter/material.dart';
import 'package:job_search_app/core/extensions/build_context_x.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: context.textStyle.bodyLarge?.copyWith(
          color: context.color.surfaceContainerLowest,
        ),
      ),
      backgroundColor: context.color.error,
    ),
  );
}
