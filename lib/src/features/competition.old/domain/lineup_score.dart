class LineupScore {
  LineupScore({
    required this.fantasyCorpsId,
    required this.fantasyCorpsName,
    required this.week,
  });
  final String fantasyCorpsId;
  final String fantasyCorpsName;
  final int week;
  Map<String, double>? scores;
}
