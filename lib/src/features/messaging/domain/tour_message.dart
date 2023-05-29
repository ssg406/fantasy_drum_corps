import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class TourMessage {
  const TourMessage(
      {this.id,
      required this.user,
      required this.userId,
      required this.tourId,
      required this.message,
      required this.dateTime});

  final String? id;
  final String user;
  final String userId;
  final String tourId;
  final String message;
  final DateTime dateTime;

  factory TourMessage.fromJson(Map<String, dynamic> json, String id) =>
      TourMessage(
        id: id,
        user: json['user'] as String,
        userId: json['userId'] as String,
        tourId: json['tourId'] as String,
        message: json['message'] as String,
        dateTime: (json['dateTime'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        'user': user,
        'userId': userId,
        'tourId': tourId,
        'message': message,
        'dateTime': dateTime,
      };

  TourMessage copyWith({
    String? user,
    String? tourId,
    String? message,
    String? userId,
    DateTime? dateTime,
  }) =>
      TourMessage(
        user: user ?? this.user,
        userId: userId ?? this.userId,
        tourId: tourId ?? this.tourId,
        message: message ?? this.message,
        dateTime: dateTime ?? this.dateTime,
      );
}
