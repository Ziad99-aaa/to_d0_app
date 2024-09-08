import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userr {
  static const String collectionName = 'Users';

  String name;
  String id;
  String email;
  String password;
  Userr(
      {
      required this.name,
      required this.id,
      required this.email,
      required this.password,
      });

  Userr.fromJson(Map<String, dynamic> data)
      : this(
          name: data['name'],
          id: data['id'],
          email: data['email'],
          password: data['password'],

        );

  Map<String, dynamic> ToFirestore() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'password': password
    };
  }
}
