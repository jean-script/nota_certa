import 'package:flutter/material.dart';

class RankingMedalWidget extends StatelessWidget {
  const RankingMedalWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const Text('🥇', style: TextStyle(fontSize: 30));
    }

    if (index == 1) {
      return const Text('🥈', style: TextStyle(fontSize: 30));
    }

    if (index == 2) {
      return const Text('🥉', style: TextStyle(fontSize: 30));
    }

    return CircleAvatar(
      backgroundColor: Colors.grey.shade100,
      child: Text(
        '${index + 1}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
