import 'package:battlestats/common/utils/cast_utils.dart';

class PlayerStats {
  String? avatar;
  String? userName;
  int? id;
  int? rank;
  String? rankImg;
  String? rankName;
  double? skill;
  double? scorePerMinute;
  double? killsPerMinute;
  String? winPercent;
  String? bestClass;
  String? accuracy;
  String? headshots;
  String? timePlayed;
  int? secondsPlayed;
  double? killDeath;
  double? infantryKillDeath;
  double? infantryKillsPerMinute;
  int? kills;
  int? deaths;
  int? wins;
  int? loses;
  double? longestHeadShot;
  double? revives;
  int? dogtagsTaken;
  int? highestKillStreak;
  int? roundsPlayed;
  double? awardScore;
  double? bonusScore;
  double? squadScore;
  int? currentRankProgress;
  int? totalRankProgress;
  int? avengerKills;
  int? saviorKills;
  int? headShots;
  double? heals;
  double? repairs;
  double? killAssists;

  PlayerStats({
    this.avatar,
    this.userName,
    this.id,
    this.rank,
    this.rankImg,
    this.rankName,
    this.skill,
    this.scorePerMinute,
    this.killsPerMinute,
    this.winPercent,
    this.bestClass,
    this.accuracy,
    this.headshots,
    this.timePlayed,
    this.secondsPlayed,
    this.killDeath,
    this.infantryKillDeath,
    this.infantryKillsPerMinute,
    this.kills,
    this.deaths,
    this.wins,
    this.loses,
    this.longestHeadShot,
    this.revives,
    this.dogtagsTaken,
    this.highestKillStreak,
    this.roundsPlayed,
    this.awardScore,
    this.bonusScore,
    this.squadScore,
    this.currentRankProgress,
    this.totalRankProgress,
    this.avengerKills,
    this.saviorKills,
    this.headShots,
    this.heals,
    this.repairs,
    this.killAssists,
  });

  PlayerStats.fromJson(Map<String, dynamic> json) {
    avatar = castOrNull<String>(json['avatar']);
    userName = castOrNull<String>(json['userName']);
    id = castOrNull<int>(json['id']);
    rank = castOrNull<int>(json['rank']);
    rankImg = castOrNull<String>(json['rankImg']);
    rankName = castOrNull<String>(json['rankName']);
    skill = castOrNull<double>(json['skill']);
    scorePerMinute = castOrNull<double>(json['scorePerMinute']);
    killsPerMinute = castOrNull<double>(json['killsPerMinute']);
    winPercent = castOrNull<String>(json['winPercent']);
    bestClass = castOrNull<String>(json['bestClass']);
    accuracy = castOrNull<String>(json['accuracy']);
    headshots = castOrNull<String>(json['headshots']);
    timePlayed = castOrNull<String>(json['timePlayed']);
    secondsPlayed = castOrNull<int>(json['secondsPlayed']);
    killDeath = castOrNull<double>(json['killDeath']);
    infantryKillDeath = castOrNull<double>(json['infantryKillDeath']);
    infantryKillsPerMinute = castOrNull<double>(json['infantryKillsPerMinute']);
    kills = castOrNull<int>(json['kills']);
    deaths = castOrNull<int>(json['deaths']);
    wins = castOrNull<int>(json['wins']);
    loses = castOrNull<int>(json['loses']);
    longestHeadShot = castOrNull<double>(json['longestHeadShot']);
    revives = castOrNull<double>(json['revives']);
    dogtagsTaken = castOrNull<int>(json['dogtagsTaken']);
    highestKillStreak = castOrNull<int>(json['highestKillStreak']);
    roundsPlayed = castOrNull<int>(json['roundsPlayed']);
    awardScore = castOrNull<double>(json['awardScore']);
    bonusScore = castOrNull<double>(json['bonusScore']);
    squadScore = castOrNull<double>(json['squadScore']);
    currentRankProgress = castOrNull<int>(json['currentRankProgress']);
    totalRankProgress = castOrNull<int>(json['totalRankProgress']);
    avengerKills = castOrNull<int>(json['avengerKills']);
    saviorKills = castOrNull<int>(json['saviorKills']);
    headShots = castOrNull<int>(json['headShots']);
    heals = castOrNull<double>(json['heals']);
    repairs = castOrNull<double>(json['repairs']);
    killAssists = castOrNull<double>(json['killAssists']);
  }

  Map<String, dynamic> toJson() {
    return {
      "avatar": avatar,
      "userName": userName,
      "id": id,
      "rank": rank,
      "rankImg": rankImg,
      "rankName": rankName,
      "skill": skill,
      "scorePerMinute": scorePerMinute,
      "killsPerMinute": killsPerMinute,
      "winPercent": winPercent,
      "bestClass": bestClass,
      "accuracy": accuracy,
      "headshots": headshots,
      "timePlayed": timePlayed,
      "secondsPlayed": secondsPlayed,
      "killDeath": killDeath,
      "infantryKillDeath": infantryKillDeath,
      "infantryKillsPerMinute": infantryKillsPerMinute,
      "kills": kills,
      "deaths": deaths,
      "wins": wins,
      "loses": loses,
      "longestHeadShot": longestHeadShot,
      "revives": revives,
      "dogtagsTaken": dogtagsTaken,
      "highestKillStreak": highestKillStreak,
      "roundsPlayed": roundsPlayed,
      "awardScore": awardScore,
      "bonusScore": bonusScore,
      "squadScore": squadScore,
      "currentRankProgress": currentRankProgress,
      "totalRankProgress": totalRankProgress,
      "avengerKills": avengerKills,
      "saviorKills": saviorKills,
      "headShots": headShots,
      "heals": heals,
      "repairs": repairs,
      "killAssists": killAssists,
    };
  }
}
