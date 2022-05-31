import 'package:battlestats/common/utils/generic_utils.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';

class VehicleStatsResponse {
  int? id;
  String? userName;
  String? avatar;
  List<VehicleStats>? vehicles;

  VehicleStatsResponse({
    this.id,
    this.userName,
    this.avatar,
    this.vehicles,
  });

  factory VehicleStatsResponse.fromJson(Map<String, dynamic> json) {
    return VehicleStatsResponse(
      avatar: castOrNull<String>(json['avatar']),
      userName: castOrNull<String>(json['userName']),
      id: castOrNull<int>(json['id']),
      vehicles: (json['vehicles'] as List<dynamic>?)
          ?.map((e) => VehicleStats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
