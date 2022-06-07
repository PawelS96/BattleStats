import 'package:battlestats/common/contants/app_colors.dart';
import 'package:flutter/material.dart';

class StatsText extends StatelessWidget {
  final String title;
  final String value;

  const StatsText({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        FittedBox(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
