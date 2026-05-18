import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItemWidget extends GetResponsiveView {
  ListItemWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.data,
  }) : super(alwaysUseBuilder: false, settings: ResponsiveScreenSettings());

  final String title;
  final String? subtitle;
  final String? data;
  final VoidCallback onTap;

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
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: isTablet ? 68 : 48,
                height: isTablet ? 68 : 48,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.school_outlined, color: Colors.blue.shade700),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: isTablet ? 16 : 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                    if (data != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        data!,
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
