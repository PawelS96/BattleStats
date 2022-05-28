import 'package:battlestats/common/widgets/list_header_item.dart';
import 'package:battlestats/models/vehicles/vehicle_sort_mode.dart';
import 'package:flutter/material.dart';

class VehicleListHeader extends StatelessWidget {
  final VehicleSortMode selectedMode;
  final Function(VehicleSortMode) onModeSelected;

  const VehicleListHeader({
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
              item: VehicleSortMode.name,
              selectedItem: selectedMode,
              onClick: onModeSelected,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListHeaderItem(
              item: VehicleSortMode.kills,
              selectedItem: selectedMode,
              onClick: onModeSelected,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListHeaderItem(
              item: VehicleSortMode.kpm,
              selectedItem: selectedMode,
              onClick: onModeSelected,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListHeaderItem(
              item: VehicleSortMode.time,
              selectedItem: selectedMode,
              onClick: onModeSelected,
            ),
          ),
        ],
      ),
    );
  }
}
