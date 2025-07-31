import 'package:flutter/material.dart';
import 'package:job_search_app/core/extensions/build_context_x.dart';
import 'package:job_search_app/core/utils/all_utils.dart';

class MainButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const MainButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: context.color.primary,
          borderRadius: borderRadius8,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: context.textStyle.labelMedium?.copyWith(
            color: context.color.surfaceContainerLowest,
          ),
        ),
      ),
    );
  }
}
