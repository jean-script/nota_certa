import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends GetResponsiveView {
  EmptyStateWidget({super.key, required this.title, required this.message})
    : super(alwaysUseBuilder: false, settings: ResponsiveScreenSettings());

  final String title;
  final String message;

  @override
  Widget phone() => _buildContent(Get.context!, isMobile: true);

  @override
  Widget tablet() => _buildContent(Get.context!, isTablet: true);

  @override
  Widget desktop() => _buildContent(Get.context!, isTablet: true);

  Widget _buildContent(
    BuildContext context, {
    bool isMobile = false,
    bool isTablet = false,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/empty.json',
              width: isTablet
                  ? 320
                  : MediaQuery.of(context).orientation == Orientation.landscape
                  ? 120
                  : 220,
              repeat: true,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet
                    ? 32
                    : MediaQuery.of(context).orientation ==
                          Orientation.landscape
                    ? 20
                    : 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet
                    ? 22
                    : MediaQuery.of(context).orientation ==
                          Orientation.landscape
                    ? 20
                    : 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
