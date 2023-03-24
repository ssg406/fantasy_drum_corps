enum Caption {
  ge1,
  ge2,
  visProf,
  visAnls,
  colorGuard,
  brass,
  ensemble,
  percussion,
}

extension CaptionName on Caption {
  String get name {
    switch (this) {
      case Caption.ge1:
        return 'General Effect 1';
      case Caption.ge2:
        return 'General Effect 2';
      case Caption.visProf:
        return 'Visual Proficiency';
      case Caption.visAnls:
        return 'Visual Analysis';
      case Caption.colorGuard:
        return 'Colorguard';
      case Caption.brass:
        return 'Brass';
      case Caption.ensemble:
        return 'Ensemble';
      case Caption.percussion:
        return 'Percussion';
    }
  }

  String get abbreviation {
    switch (this) {
      case Caption.ge1:
        return 'GE 1';
      case Caption.ge2:
        return 'GE 2';
      case Caption.visProf:
        return 'Vis. Prof';
      case Caption.visAnls:
        return 'Vis. Anls';
      case Caption.colorGuard:
        return 'Colorguard';
      case Caption.brass:
        return 'Brass';
      case Caption.ensemble:
        return 'Ensemble';
      case Caption.percussion:
        return 'Percussion';
    }
  }
}
