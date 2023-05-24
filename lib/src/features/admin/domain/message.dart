import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class AdminMessage {
  const AdminMessage(
      {this.id, required this.title, required this.text, required this.date});

  final String? id;
  final String title;
  final String text;
  final DateTime date;

  factory AdminMessage.fromJson(Map<String, dynamic> json, String id) =>
      AdminMessage(
          id: id,
          title: json['title'] as String,
          text: json['text'] as String,
          date: (json['date'] as Timestamp).toDate()
      );

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'text': text,
        'date': date,
      };

  AdminMessage copyWith({String? title, String? text, DateTime? date}) =>
      AdminMessage(
        title: title ?? this.title,
        text: text ?? this.text,
        date: date ?? this.date,
      );
}