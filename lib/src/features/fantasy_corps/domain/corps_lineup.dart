class CorpsLineup {
  CorpsLineup({
    required this.userId,
    this.generalEffect1,
    this.generalEffect2,
    this.visualProficiency,
    this.visualAnalysis,
    this.colorGuard,
    this.brass,
    this.musicAnalysis1,
    this.musicAnalysis2,
    this.percussion,
  });
  final String userId;
  String? generalEffect1;
  String? generalEffect2;
  String? visualProficiency;
  String? visualAnalysis;
  String? colorGuard;
  String? brass;
  String? musicAnalysis1;
  String? musicAnalysis2;
  String? percussion;

  factory CorpsLineup.fromJson(Map<String, dynamic> json) {
    return CorpsLineup(
      userId: json['userId'] as String,
      generalEffect1: json['generalEffect1'] as String?,
      generalEffect2: json['generalEffect2'] as String?,
      visualProficiency: json['visualProficiency'] as String?,
      visualAnalysis: json['visualAnalysis'] as String?,
      colorGuard: json['colorGuard'] as String?,
      brass: json['brass'] as String?,
      musicAnalysis1: json['musicAnalysis1'] as String?,
      musicAnalysis2: json['musicAnalysis2'] as String?,
      percussion: json['percussion'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'generalEffect1': generalEffect1,
      'generalEffect2': generalEffect2,
      'visualProficiency': visualProficiency,
      'visualAnalysis': visualAnalysis,
      'colorGuard': colorGuard,
      'brass': brass,
      'musicAnalysis1': musicAnalysis1,
      'musicAnalysis2': musicAnalysis2,
      'percussion': percussion,
    };
  }
}
