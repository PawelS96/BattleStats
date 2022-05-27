import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const NavButton({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 60,
      onPressed: onClick,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
