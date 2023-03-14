import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

typedef TourID = String;

/// Model class which represents a FantasyDC league
class Tour {
  Tour({
    this.id,
    required this.name,
    required this.description,
    required this.isPublic,
    required this.owner,
    this.slotsAvailable = 8,
    required this.members,
    required this.draftDateTime,
    this.password,
  });
  final TourID? id;
  final String name;
  final String description;
  final bool isPublic;
  final String owner;
  final int slotsAvailable;
  final List<String> members;
  final DateTime draftDateTime;
  String? password;

  factory Tour.fromJson(Map<String, dynamic> json, String id) {
    return Tour(
      id: id,
      name: json['leagueName'] as String,
      description: json['description'] as String,
      isPublic: json['isPublic'] as bool,
      owner: json['owner'] as String,
      slotsAvailable: json['slotsAvailable'] as int,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      draftDateTime: (json['draftDateTime'] as Timestamp).toDate(),
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'leagueName': name,
        'description': description,
        'isPublic': isPublic,
        'owner': owner,
        'slotsAvailable': slotsAvailable,
        'members': members,
        'password': password,
        'draftDateTime': draftDateTime,
      };
}
