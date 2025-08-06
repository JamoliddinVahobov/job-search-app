import 'package:flutter/material.dart';
import 'package:job_search_app/core/extensions/build_context_x.dart';
import 'package:job_search_app/core/utils/utils.dart';

class MainSearchField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Function()? clearOnTap;

  const MainSearchField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.clearOnTap,
  });

  @override
  State<MainSearchField> createState() => _MainSearchFieldState();
}

class _MainSearchFieldState extends State<MainSearchField> {
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (widget.controller?.text.isNotEmpty ?? false) {
        setState(() => _showClear = true);
      } else {
        setState(() => _showClear = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
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
                  widget.controller?.clear();
                  widget.clearOnTap?.call();
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      ),
    );
  }
}
