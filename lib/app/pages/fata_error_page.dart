import 'package:flutter/material.dart';

class FataErrorPage extends StatelessWidget {
  const FataErrorPage({
    super.key,
    this.title,
    this.message,
    this.buttonText,
    this.onRetry,
  });

  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 56,
                  color: Colors.red.shade400,
                ),
              ),

              const SizedBox(height: 28),

              Text(
                title ?? 'Algo deu errado',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Text(
                  message ??
                      'Ocorreu um erro inesperado ao carregar as informações.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (onRetry != null)
                SizedBox(
                  width: 220,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(buttonText ?? 'Tente novamente'),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
