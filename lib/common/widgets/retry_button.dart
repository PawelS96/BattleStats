import 'package:battlestats/common/contants/app_colors.dart';
import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onClick;

  const RetryButton({
    Key? key,
    this.text = 'Something went wrong',
    this.buttonText = 'Try again',
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          text,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 18),
        ),
        const SizedBox(height: 8),
        MaterialButton(
          onPressed: onClick,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
