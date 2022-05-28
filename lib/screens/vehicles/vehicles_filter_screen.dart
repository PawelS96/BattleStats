import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/filter_buttons.dart';
import 'package:battlestats/common/widgets/filter_list_item.dart';
import 'package:battlestats/screens/vehicles/vehicles_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclesFilterScreen extends StatelessWidget {
  const VehiclesFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VehiclesViewModel>();
    final types = vm.vehicleTypes;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Vehicle types'.toUpperCase()),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                if (index == 0) {
                  return FilterButtons(
                    onAllClicked: vm.selectAllTypes,
                    oneNoneClicked: vm.selectNoTypes,
                  );
                }

                final type = types[index - 1];
                return FilterListItem(
                  text: type,
                  isSelected: vm.selectedVehicleTypes.contains(type),
                  onClick: () => vm.onVehicleTypeClicked(type),
                );
              },
              separatorBuilder: (ctx, index) {
                return Container(
                  height: 0.5,
                  color: Colors.grey,
                );
              },
              itemCount: types.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}
