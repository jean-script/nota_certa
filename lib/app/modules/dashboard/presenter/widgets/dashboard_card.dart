import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isTablet;
  final Color iconColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.isTablet,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: isTablet ? 38 : 28, color: iconColor),
              Text(
                value,
                style: TextStyle(
                  fontSize: isTablet ? 36 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: isTablet ? 32 : null,
            ),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [

          //   ],
          // ),
        ],
      ),
    );
  }
}
