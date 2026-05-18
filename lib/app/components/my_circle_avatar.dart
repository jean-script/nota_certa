import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  const MyCircleAvatar({super.key, required this.text, this.radius});

  final String text;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isTablet = size.width >= 700;

    final avatarRadius = radius ?? (isTablet ? 28 : 18);

    return Container(
      constraints: BoxConstraints(
        minHeight: 30,
        minWidth: 30,
        maxHeight: 40,
        maxWidth: 40,
      ),
      alignment: Alignment.center,
      // padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.blue.shade50,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: avatarRadius * 0.9,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade700,
        ),
      ),
    );
    // CircleAvatar(
    //   radius: avatarRadius,
    //   backgroundColor: Colors.blue.shade50,
    //   child: Text(
    //     text,
    //     style: TextStyle(
    //       fontSize: avatarRadius * 0.9,
    //       fontWeight: FontWeight.bold,
    //       color: Colors.blue.shade700,
    //     ),
    //   ),
    // );
  }
}
