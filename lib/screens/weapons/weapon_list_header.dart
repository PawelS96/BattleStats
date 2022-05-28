import 'package:battlestats/common/widgets/list_header_item.dart';
import 'package:battlestats/models/weapons/weapon_sort_mode.dart';
import 'package:flutter/material.dart';

class WeaponListHeader extends StatelessWidget {
  final WeaponSortMode selectedMode;
  final Function(WeaponSortMode) onModeSelected;

  const WeaponListHeader({
    Key? key,
    required this.selectedMode,
    required this.onModeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListHeaderItem(
              item: WeaponSortMode.name,
              selectedItem: selectedMode,
              onClick: onModeSelected,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListHeaderItem(
              item: WeaponSortMode.kills,
              selectedItem: selectedMode,
              onClick: onModeSelected,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListHeaderItem(
              item: WeaponSortMode.kpm,
              selectedItem: selectedMode,
              onClick: onModeSelected,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListHeaderItem(
              item: WeaponSortMode.time,
              selectedItem: selectedMode,
              onClick: onModeSelected,
            ),
          ),
        ],
      ),
    );
  }
}
