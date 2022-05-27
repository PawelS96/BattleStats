import 'package:battlestats/common/contants/app_colors.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlayerListItem extends StatelessWidget {
  final Player player;
  final bool isSelected;
  final Function(Player) onClick;
  final Function(Player) onClickDelete;

  const PlayerListItem({
    Key? key,
    required this.player,
    required this.isSelected,
    required this.onClick,
    required this.onClickDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(player),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: player.avatar ?? '',
          height: 40,
          width: 40,
          imageBuilder: (ctx, image) => CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 60,
            child: Padding(
              padding: EdgeInsets.all(isSelected ? 2 : 0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: image,
              ),
            ),
          ),
          placeholder: (_, __) => const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
          errorWidget: (ctx, _, __) => Container(
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            decoration: isSelected
                ? BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  )
                : null,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              player.name,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              player.platform.displayedName,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.white,
          ),
          onPressed: () => onClickDelete(player),
        ),
      ),
    );
  }
}

class AddPlayerListItem extends StatelessWidget {
  final VoidCallback onClick;

  const AddPlayerListItem({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: const ListTile(
        leading: Icon(
          Icons.add,
          color: Colors.white,
        ),
        title: Text(
          'Add new player',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
