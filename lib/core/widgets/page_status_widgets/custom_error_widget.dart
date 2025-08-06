import 'package:flutter/material.dart';
import 'package:job_search_app/core/extensions/build_context_x.dart';
import 'package:job_search_app/core/utils/utils.dart';
import 'package:job_search_app/core/widgets/buttons/main_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomErrorWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error occured',
            style: context.textStyle.bodyLarge?.copyWith(
              color: context.color.secondary,
            ),
          ),
          h16,
          Padding(
            padding: paddingHor20,
            child: MainButton(label: 'Retry', onTap: onTap),
          ),
        ],
      ),
    );
  }
}
