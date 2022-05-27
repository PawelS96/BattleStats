import 'package:battlestats/app/app_viewmodel.dart';
import 'package:battlestats/common/contants/app_colors.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/screens/add_player/add_player_screen.dart';
import 'package:battlestats/screens/main/main_viewmodel.dart';
import 'package:battlestats/screens/main/player_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final Player player;

  const MainScreen({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = MainViewModel.of(context, widget.player);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<MainViewModel>(
        builder: (ctx, vm, _) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              const BackgroundImage(),
              SafeArea(top: false, child: _content(vm)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(MainViewModel vm) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
          ],
        ),
      ),
    );
  }

  Widget _changePlayerButton() {
    return MaterialButton(
      onPressed: _showPlayerList,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 2, color: AppColors.textPrimary),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Text(
        "Change player",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageBuilder: (ctx, image) => CircleAvatar(backgroundImage: image, radius: 50),
            placeholder: (_, __) => const SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
            imageUrl: widget.player.avatar ?? '',
            errorWidget: (ctx, _, __) => Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 80,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: const BorderRadius.all(Radius.circular(75)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.player.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        _changePlayerButton(),
      ],
    );
  }

  void _showAddPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddPlayerScreen(
          onAdded: (player) {
            Navigator.pop(context);
            vm.onPlayerAdded(player);
          },
          showKeyboard: true,
        ),
      ),
    );
  }

  void _showPlayerList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (sheetContext) {
        final appVM = sheetContext.watch<AppViewModel>();
        return ChangeNotifierProvider.value(
          value: vm,
          child: Consumer<MainViewModel>(
            builder: (ctx, vm, _) => SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    AddPlayerListItem(
                      onClick: () {
                        Navigator.pop(sheetContext);
                        _showAddPlayer();
                      },
                    ),
                    for (var player in vm.players)
                      PlayerListItem(
                        player: player,
                        isSelected: player == appVM.currentPlayer,
                        onClick: (player) {
                          Navigator.pop(sheetContext);
                          vm.selectPlayer(player);
                        },
                        onClickDelete: (player) {
                          if (vm.players.length == 1) {
                            Navigator.pop(sheetContext);
                          }
                          vm.deletePlayer(player);
                        },
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
