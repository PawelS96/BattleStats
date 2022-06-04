class ProgressStats {
  final String name;
  final int current;
  final int total;

  ProgressStats({
    required this.name,
    required this.current,
    required this.total,
  });

  factory ProgressStats.fromJson(Map json) {
    return ProgressStats(
      name: json["progressName"],
      current: json["current"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressName": name,
      "current": current,
      "total": total,
    };
  }
}
