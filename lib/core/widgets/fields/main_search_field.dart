import 'package:flutter/material.dart';
import 'package:job_search_app/core/extensions/build_context_x.dart';
import 'package:job_search_app/core/utils/utils.dart';

class MainSearchField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const MainSearchField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  State<MainSearchField> createState() => _MainSearchFieldState();
}

class _MainSearchFieldState extends State<MainSearchField> {
  late final TextEditingController _controller;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _showClear = _controller.text.isNotEmpty;

    _controller.addListener(() {
      final shouldShow = _controller.text.isNotEmpty;
      if (shouldShow != _showClear && context.mounted) {
        setState(() => _showClear = shouldShow);
      }
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius10,
          borderSide: BorderSide(
            color: context.color.surfaceContainerHighest,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius10,
          borderSide: BorderSide(color: context.color.primary, width: 1.6),
        ),
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _showClear
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
