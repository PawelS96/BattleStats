import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/retry_button.dart';
import 'package:battlestats/models/weapons/weapon_stats.dart';
import 'package:battlestats/screens/weapons/weapon_details_screen.dart';
import 'package:battlestats/screens/weapons/weapon_list_header.dart';
import 'package:battlestats/screens/weapons/weapon_list_item.dart';
import 'package:battlestats/screens/weapons/weapons_filter_screen.dart';
import 'package:battlestats/screens/weapons/weapons_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeaponsScreen extends StatelessWidget {
  const WeaponsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeaponsViewModel>(
      builder: (ctx, vm, _) => Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Weapons'),
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

                  if (vm.selectedWeaponTypes.isEmpty) {
                    return Center(
                      child: RetryButton(
                          text: 'No weapon types selected',
                          buttonText: 'Change filters',
                          onClick: () => _showFilters(context, vm)),
                    );
                  }

                  return _weaponList(context, vm);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _weaponList(BuildContext context, WeaponsViewModel vm) {
    return Column(
      children: [
        WeaponListHeader(
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
              itemCount: vm.weapons.length,
              itemBuilder: (ctx, index) {
                return WeaponListItem(
                  weaponStats: vm.weapons[index],
                  onClick: (stats) => _showDetails(context, stats),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showFilters(BuildContext context, WeaponsViewModel vm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChangeNotifierProvider.value(
          value: vm,
          child: const WeaponFilterScreen(),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, WeaponStats weaponStats) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => WeaponDetailsScreen(
          weaponStats: weaponStats,
        ),
      ),
    );
  }
}
