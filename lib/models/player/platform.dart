enum GamingPlatform { pc, ps4, xboxone }

extension GamingPlatformExt on GamingPlatform {
  String get displayedName {
    return switch (this) {
      GamingPlatform.pc => 'PC',
      GamingPlatform.ps4 => 'PS4',
      GamingPlatform.xboxone => 'Xbox One'
    };
  }
}
