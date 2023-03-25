enum Caption {
  ge1,
  ge2,
  visualProficiency,
  visualAnalysis,
  colorGuard,
  brass,
  musicAnalysis,
  percussion,
}

extension CaptionName on Caption {
  String get name {
    switch (this) {
      case Caption.ge1:
        return 'General Effect 1';
      case Caption.ge2:
        return 'General Effect 2';
      case Caption.visualProficiency:
        return 'Visual Proficiency';
      case Caption.visualAnalysis:
        return 'Visual Analysis';
      case Caption.colorGuard:
        return 'Colorguard';
      case Caption.brass:
        return 'Brass';
      case Caption.percussion:
        return 'Percussion';
      case Caption.musicAnalysis:
        return 'Music Analysis';
    }
  }

  String get abbreviation {
    switch (this) {
      case Caption.ge1:
        return 'GE 1';
      case Caption.ge2:
        return 'GE 2';
      case Caption.visualProficiency:
        return 'Vis. Prof';
      case Caption.visualAnalysis:
        return 'Vis. Anls';
      case Caption.colorGuard:
        return 'Colorguard';
      case Caption.brass:
        return 'Brass';
      case Caption.musicAnalysis:
        return 'Music Anls.';
      case Caption.percussion:
        return 'Percussion';
    }
  }
}
