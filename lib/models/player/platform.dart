enum GamingPlatform { pc, ps4, xboxone }

extension GamingPlatformExt on GamingPlatform {
  String get displayedName {
    switch (this) {
      case GamingPlatform.pc:
        return 'PC';
      case GamingPlatform.ps4:
        return 'PS4';
      case GamingPlatform.xboxone:
        return 'Xbox One';
    }
  }
}


