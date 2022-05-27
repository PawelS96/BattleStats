String formatTime(int ms) {
  final duration = Duration(milliseconds: ms);
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);

  if (hours == 0) {
    return '${minutes}m';
  }

  return "${hours}h ${minutes}m";
}