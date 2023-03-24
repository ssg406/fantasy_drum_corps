enum DrumCorps {
  theAcademy,
  blueDevils,
  blueKnights,
  blueStars,
  bluecoats,
  bostonCrusaders,
  theCadets,
  carolinaCrown,
  theCavaliers,
  colts,
  crossmen,
  genesis,
  jerseySurf,
  madisonScouts,
  mandarins,
  musicCity,
  pacificCrest,
  phantomRegiment,
  santaClaraVanguard,
  seattleCascades,
  spiritOfAtlanta,
  troopers,
}

extension DrumCorpsNames on DrumCorps {
  String get fullName {
    switch (this) {
      case DrumCorps.theAcademy:
        return 'The Academy';
      case DrumCorps.blueDevils:
        return 'Blue Devils';
      case DrumCorps.blueKnights:
        return 'Blue Knights';
      case DrumCorps.blueStars:
        return 'Blue Stars';
      case DrumCorps.bluecoats:
        return 'Bluecoats';
      case DrumCorps.bostonCrusaders:
        return 'Boston Crusaders';
      case DrumCorps.theCadets:
        return 'The Cadets';
      case DrumCorps.carolinaCrown:
        return 'Carolina Crown';
      case DrumCorps.theCavaliers:
        return 'The Cavaliers';
      case DrumCorps.colts:
        return 'Colts';
      case DrumCorps.crossmen:
        return 'Crossmen';
      case DrumCorps.genesis:
        return 'Genesis';
      case DrumCorps.jerseySurf:
        return 'Jersey Surf';
      case DrumCorps.madisonScouts:
        return 'Madison Scouts';
      case DrumCorps.mandarins:
        return 'Mandarins';
      case DrumCorps.musicCity:
        return 'Music City';
      case DrumCorps.pacificCrest:
        return 'Pacific Crest';
      case DrumCorps.phantomRegiment:
        return 'Phantom Regiment';
      case DrumCorps.santaClaraVanguard:
        return 'Santa Clara Vanguard';
      case DrumCorps.seattleCascades:
        return 'Seattle Cascades';
      case DrumCorps.spiritOfAtlanta:
        return 'Spirit of Atlanta';
      case DrumCorps.troopers:
        return 'Troopers';
    }
  }
}
