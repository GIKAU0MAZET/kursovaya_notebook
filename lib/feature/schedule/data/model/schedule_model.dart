import 'package:flutter/material.dart';

class ScheduleEvent {
  final String id;
  final String title;
  final String description;
  final int day; // 1-6 (пн-сб)
  final int pairNumber; // 1-7
  final TimeOfDay time;

  ScheduleEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.day,
    required this.pairNumber,
    required this.time,
  });
}