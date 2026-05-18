import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hintText;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          // BoxShadow(
          //   blurRadius: 10,
          //   offset: const Offset(0, 4),
          //   color: Colors.black.withValues(alpha: 0.04),
          // ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText ?? 'Pesquisar escola',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade500),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    if (onChanged != null) {
                      onChanged!('');
                    }
                  },
                  icon: const Icon(Icons.close_rounded),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.shade200, width: 1.4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.blue.shade100, width: 1.4),
          ),
        ),
      ),
    );
  }
}
