import 'package:flutter/material.dart';

class ListHeaderItem<T extends Enum> extends StatelessWidget {
  final T item;
  final T selectedItem;
  final Function(T) onClick;

  const ListHeaderItem({
    Key? key,
    required this.item,
    required this.selectedItem,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const selectedTextStyle = TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    const standardTextStyle = TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w300,
    );

    return MaterialButton(
      onPressed: () => onClick(item),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: FittedBox(
          child: Text(
            item.name.toUpperCase(),
            style: selectedItem == item ? selectedTextStyle : standardTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
