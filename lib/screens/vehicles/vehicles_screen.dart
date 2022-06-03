import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/retry_button.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:battlestats/screens/vehicles/vehicle_details_screen.dart';
import 'package:battlestats/screens/vehicles/vehicle_list_header.dart';
import 'package:battlestats/screens/vehicles/vehicle_list_item.dart';
import 'package:battlestats/screens/vehicles/vehicles_filter_screen.dart';
import 'package:battlestats/screens/vehicles/vehicles_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VehiclesViewModel>(
      builder: (ctx, vm, _) => Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Vehicles'),
          actions: [
            if (!vm.isLoading && !vm.isError)
              MaterialButton(
                onPressed: () => _showFilters(context, vm),
                child: const Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                ),
                shape: const CircleBorder(),
              )
          ],
        ),
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: Builder(
                builder: (ctx) {
                  if (vm.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (vm.isError) {
                    return Center(
                      child: RetryButton(onClick: vm.retry),
                    );
                  }

                  if (vm.selectedVehicleTypes.isEmpty) {
                    return Center(
                      child: RetryButton(
                          text: 'No vehicle types selected',
                          buttonText: 'Change filters',
                          onClick: () => _showFilters(context, vm)),
                    );
                  }

                  return _vehicleList(context, vm);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _vehicleList(BuildContext context, VehiclesViewModel vm) {
    return Column(
      children: [
        VehicleListHeader(
          selectedMode: vm.sortMode,
          onModeSelected: vm.onSortModeClicked,
        ),
        Container(
          height: 0.5,
          color: Colors.grey,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: vm.refresh,
            child: ListView.separated(
              separatorBuilder: (ctx, index) {
                return Container(
                  height: 0.5,
                  color: Colors.grey,
                );
              },
              itemCount: vm.vehicles.length,
              itemBuilder: (ctx, index) {
                return VehicleListItem(
                  vehicleStats: vm.vehicles[index],
                  onClick: (stats) => _showDetails(context, stats),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showFilters(BuildContext context, VehiclesViewModel vm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChangeNotifierProvider.value(
          value: vm,
          child: const VehiclesFilterScreen(),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, VehicleStats vehicleStats) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => VehicleDetailsScreen(
          vehicleStats: vehicleStats,
        ),
      ),
    );
  }
}
