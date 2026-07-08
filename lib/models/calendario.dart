import 'package:flutter/material.dart';

class Calendario {
  final String id;
  final String title;
  final String process;
  final String category;
  final DateTime date;
  final Color color;
  final bool reminder;

  const Calendario({
    required this.id,
    required this.title,
    required this.process,
    required this.category,
    required this.date,
    required this.color,
    this.reminder = false,
  });

  Calendario copyWith({
    String? id,
    String? title,
    String? process,
    String? category,
    DateTime? date,
    Color? color,
    bool? reminder,
  }) {
    return Calendario(
      id: id ?? this.id,
      title: title ?? this.title,
      process: process ?? this.process,
      category: category ?? this.category,
      date: date ?? this.date,
      color: color ?? this.color,
      reminder: reminder ?? this.reminder,
    );
  }
}
