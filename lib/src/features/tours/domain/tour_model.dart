import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:quiver/core.dart';

typedef TourID = String;

/// Model class which represents a FantasyDC league
class Tour {
  const Tour({
    this.id,
    required this.name,
    required this.description,
    required this.isPublic,
    required this.owner,
    required this.members,
    required this.draftDateTime,
    required this.draftComplete,
    this.password,
  });

  final TourID? id;
  final String name;
  final String description;
  final bool isPublic;
  final String owner;
  final List<String> members;
  final DateTime draftDateTime;
  final bool draftComplete;
  final String? password;

  static const maxTourSize = 22;

  void removePlayerFromTour(String playerId) {
    if (playerId == owner) {
      throw StateError('Cannot remove owner from tour');
    }
    if (!members.remove(playerId)) {
      throw StateError('Unable to remove player from tour');
    }
  }

  int get slotsAvailable => maxTourSize - members.length;

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
      draftComplete: json['draftComplete'] as bool,
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
        'draftComplete': draftComplete,
      };

  Tour copyWith(
      {String? tourName,
      String? description,
      bool? isPublic,
      String? owner,
      List<String>? members,
      String? password,
      DateTime? draftDateTime,
      bool? draftComplete,
      List<DrumCorpsCaption>? leftOverPicks}) {
    return Tour(
      id: id,
      name: tourName ?? name,
      description: description ?? this.description,
      isPublic: isPublic ?? this.isPublic,
      owner: owner ?? this.owner,
      members: members ?? this.members,
      password: password ?? this.password,
      draftDateTime: draftDateTime ?? this.draftDateTime,
      draftComplete: draftComplete ?? this.draftComplete,
    );
  }

  void addPlayer(String playerId) {
    if (members.length < maxTourSize) {
      members.add(playerId);
    } else {
      throw StateError('Tour already has $maxTourSize members');
    }
  }

  @override
  String toString() => 'Tour(id: $id, '
      'name: $name, '
      'description: $description, '
      'isPublic: $isPublic, '
      'owner: $owner, '
      'members: ${members.join(', ')}, '
      'password: $password, '
      'draftDateTime: $draftDateTime, '
      'draftComplete: $draftComplete)';

  @override
  int get hashCode => hash4(id, name, owner, members);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;

    return other is Tour &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.isPublic == isPublic &&
        other.owner == owner &&
        other.members == members &&
        other.password == password &&
        other.draftComplete == draftComplete &&
        other.draftDateTime == draftDateTime;
  }
}
