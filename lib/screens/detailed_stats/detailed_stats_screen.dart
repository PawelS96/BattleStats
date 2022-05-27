import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:flutter/material.dart';

class DetailedStatsScreen extends StatelessWidget {
  final PlayerStats stats;

  const DetailedStatsScreen({
    Key? key,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _statsRow('Kills', stats.kills ?? 0),
                    _statsRow('Deaths', stats.deaths ?? 0),
                    _statsRow('K/D ratio', stats.killDeath ?? 0),
                    _statsRow('Time played', stats.timePlayed ?? formatTime(0)),
                    _statsRow('Kills per minute', stats.killsPerMinute ?? 0),
                    _statsRow('Score per minute', stats.scorePerMinute ?? 0),
                    _statsRow('Kill assists', stats.killAssists?.toInt() ?? 0),
                    _statsRow('Wins', stats.wins ?? 0),
                    _statsRow('Loses', stats.loses ?? 0),
                    _statsRow('Win percent', stats.winPercent ?? '0%'),
                    _statsRow('Rounds played', stats.roundsPlayed ?? 0),
                    _statsRow('Skill', stats.skill ?? 0),
                    _statsRow('Accuracy', stats.accuracy ?? '0%'),
                    _statsRow('Heals', stats.heals?.toInt() ?? 0),
                    _statsRow('Repairs', stats.repairs?.toInt() ?? 0),
                    _statsRow('Revives', stats.revives?.toInt() ?? 0),
                    _statsRow('Headshots', stats.headshots ?? '0%'),
                    _statsRow('Longest headshot', stats.longestHeadShot ?? 0),
                    _statsRow('Avenger kills', stats.avengerKills ?? 0),
                    _statsRow('Savior kills', stats.saviorKills ?? 0),
                    _statsRow('Highest killstreak', stats.highestKillStreak ?? 0),
                    _statsRow('Award score', stats.awardScore?.toInt() ?? 0),
                    _statsRow('Bonus score', stats.bonusScore?.toInt() ?? 0),
                    _statsRow('Squad score', stats.squadScore?.toInt() ?? 0),
                    _statsRow('Best class', stats.bestClass ?? ''),
                    _statsRow('Dogtags taken', stats.dogtagsTaken ?? 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsRow(String title, dynamic value) {
    const style = TextStyle(fontSize: 18, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: style),
            Text(value.toString(), style: style),
          ],
        ),
      ),
    );
  }
}
