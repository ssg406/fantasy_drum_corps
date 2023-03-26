import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

typedef TourID = String;

/// Model class which represents a FantasyDC league
@immutable
class Tour {
  const Tour({
    this.id,
    required this.name,
    required this.description,
    required this.isPublic,
    required this.owner,
    required this.members,
    required this.draftDateTime,
    this.password,
  });

  static const int tourSize = 8;

  final TourID? id;
  final String name;
  final String description;
  final bool isPublic;
  final String owner;
  final List<String> members;
  final DateTime draftDateTime;
  final String? password;

  int get slotsAvailable => tourSize - members.length;

  factory Tour.fromJson(Map<String, dynamic> json, String id) {
    return Tour(
      id: id,
      name: json['name'] as String,
      description: json['description'] as String,
      isPublic: json['isPublic'] as bool,
      owner: json['owner'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      draftDateTime: (json['draftDateTime'] as Timestamp).toDate(),
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'description': description,
        'isPublic': isPublic,
        'owner': owner,
        'slotsAvailable': slotsAvailable,
        'members': members,
        'password': password,
        'draftDateTime': draftDateTime,
      };

  Tour copyWith(
      {String? tourName,
      String? description,
      bool? isPublic,
      String? owner,
      List<String>? members,
      String? password,
      DateTime? draftDateTime}) {
    return Tour(
      name: tourName ?? name,
      description: description ?? this.description,
      isPublic: isPublic ?? this.isPublic,
      owner: owner ?? this.owner,
      members: members ?? this.members,
      password: password ?? this.password,
      draftDateTime: draftDateTime ?? this.draftDateTime,
    );
  }

  void addPlayer(String playerId) {
    if (members.length < tourSize) {
      members.add(playerId);
    } else {
      throw StateError('Tour already has $tourSize members');
    }
  }
}
