class DrumCorpsData {
  static const corpsNames = [
    'The Academy',
    'Blue Devils',
    'Blue Knights',
    'Blue Stars',
    'Bluecoats',
    'Boston Crusaders',
    'The Cadets',
    'Carolina Crown',
    'The Cavaliers',
    'Colts',
    'Crossmen',
    'Genesis',
    'Jersey Surf',
    'Madison Scouts',
    'Mandarins',
    'Music City',
    'Pacific Crest',
    'Phantom Regiment',
    'Santa Clara Vanguard',
    'Seattle Cascades',
    'Spirit of Atlanta',
    'Troopers',
  ];

  static const captionNames = <String, String>{
    'GE 1': 'General Effect 1',
    'GE 2': 'General Effect 2',
    'Vis. Prof': 'Visual Proficiency',
    'Vis. Anls': 'Visual Analysis',
    'Colorguard': 'Colorguard',
    'Brass': 'Brass',
    'Ensemble': 'Ensemble',
    'Percussion': 'Percussion'
  };

  static const abbreviationLookup = <String, String>{
    'General Effect 1': 'GE 1',
    'General Effect 2': 'GE 2',
    'Visual Proficiency': 'Vis. Prof.',
    'Visual Analysis': 'Vis. Anls',
    'Colorguard': 'Colorguard',
    'Brass': 'Brass',
    'Ensemble': 'Ensemble',
    'Percussion': 'Percussion',
  };

  static List<String> get captionAbbreviations => captionNames.keys.toList();

  static List<String> get captionFullNames => captionNames.values.toList();

  static List<String> get allNames => corpsNames;
}
