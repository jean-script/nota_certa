import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SizedBox(
            width: 42,
            height: 42,

            child: CircularProgressIndicator(strokeWidth: 3),
          ),

          const SizedBox(height: 24),

          Text(
            'Carregando dados...',

            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
