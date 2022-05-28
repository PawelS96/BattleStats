import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final VoidCallback onAllClicked;
  final VoidCallback oneNoneClicked;

  const FilterButtons({
    Key? key,
    required this.onAllClicked,
    required this.oneNoneClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          onPressed: onAllClicked,
          child: const Text(
            'ALL',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        MaterialButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          onPressed: oneNoneClicked,
          child: const Text(
            'NONE',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
