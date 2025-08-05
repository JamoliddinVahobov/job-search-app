part of 'utils.dart';

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
