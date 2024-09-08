import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  static const String collectionName = 'tasks';

  String title;
  String desc;
  DateTime date;
  String id;
  bool isDone;
  Task(
      {this.isDone = false,
      required this.title,
      required this.desc,
      required this.date,
      this.id = ''});

  Task.fromJson(Map<String, dynamic> data)
      : this(
          title: data['title'],
          id: data['id'],
          date: DateTime.fromMillisecondsSinceEpoch(data['date']),
          isDone: data['isDone'],
          desc: data['desc'],
        );

  Map<String, dynamic> ToFirestore() {
    return {
      'title': title,
      'desc': desc,
      'id': id,
      'isDone': isDone,
      'date': date.millisecondsSinceEpoch
    };
  }
}
