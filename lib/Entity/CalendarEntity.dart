import 'package:flutter/material.dart';

enum MultiDaySegement {
  first,
  middle,
  last,
}

class CalendarEntity {
  String summary;
  String description;
  String location;
  DateTime startTime;
  Color? color;
  bool isAllDay;
  bool isMultiDay;
  MultiDaySegement? multiDaySegement;
  bool isDone;
  Map<String, dynamic>? metadata;

  CalendarEntity(this.summary,
      {this.description = '',
      this.location = '',
      required this.startTime,
      this.color = Colors.blue,
      this.isAllDay = false,
      this.isMultiDay = false,
      this.isDone = false,
      multiDaySegement,
      this.metadata});
}