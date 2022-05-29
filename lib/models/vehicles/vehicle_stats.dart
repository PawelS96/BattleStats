import 'package:battlestats/common/utils/cast_utils.dart';
import 'package:battlestats/common/utils/string_extensions.dart';

class VehicleStats {
  String vehicleName;
  String type;
  String? image;
  int kills;
  double killsPerMinute;
  int destroyed;
  int timeIn;

  VehicleStats({
    required this.vehicleName,
    required this.type,
    this.image,
    required this.kills,
    required this.killsPerMinute,
    required this.destroyed,
    required this.timeIn,
  });

  factory VehicleStats.fromJson(Map<String, dynamic> json) {
    return VehicleStats(
      vehicleName: castOrNull<String>(json['vehicleName']) ?? '',
      type: castOrNull<String>(json['type']) ?? '',
      image: castOrNull<String>(json['image']),
      kills: castOrNull<int>(json['kills']) ?? 0,
      killsPerMinute: castOrNull<num>(json['killsPerMinute'])?.toDouble() ?? 0,
      destroyed: castOrNull<int>(json['destroyed']) ?? 0,
      timeIn: castOrNull<int>(json['timeIn']) ?? 0,
    );
  }

  int get starCount => kills ~/ 100;

  String get formattedName =>
      vehicleName.withTrimmedSpaces().withCapitalizedWords().withUppercaseWords(
        [
          'Ft-17',
          'A7v',
          'M.a.s.',
          'F2.b',
          'Dr.1',
          'Qf',
          'Aa',
          'G.iv',
          'Diii',
          'F.t.',
          'Xiii',
          'Ca.5',
          'C.i',
          'Dh.10',
          'A.e.f',
          '2-a2',
          '2c',
          'Ev4',
          'Mc',
          '18j',
          '3.5hp',
        ],
      );
}