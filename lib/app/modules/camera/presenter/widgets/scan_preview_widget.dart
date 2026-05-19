import 'dart:io';

import 'package:flutter/material.dart';

class ScanPreviewWidget extends StatelessWidget {
  const ScanPreviewWidget({
    super.key,
    required this.file,
    this.onRemove,
    this.onRetake,
  });

  final File file;

  final VoidCallback? onRemove;

  final VoidCallback? onRetake;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),

            child: Image.file(
              file,
              width: double.infinity,
              height: 260,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),

            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        'Cartão resposta',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Imagem pronta para análise',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                if (onRetake != null)
                  IconButton.filledTonal(
                    onPressed: onRetake,
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey.shade700,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.blue.shade50,
                      ),
                    ),
                  ),

                if (onRemove != null)
                  IconButton.filledTonal(
                    onPressed: onRemove,
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.grey.shade700,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.blue.shade50,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
