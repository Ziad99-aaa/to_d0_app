import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_d0_app/Task.dart';
import 'package:to_d0_app/TaskWidget.dart';
import 'package:to_d0_app/User.dart';

class Firestore {
  static CollectionReference<Task> getTasksCollection(String Uid) {
    var collectionref = getUsersCollection();
    return collectionref.doc(Uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromJson(snapshot.data()!)),
            toFirestore: ((Task, options) => Task.ToFirestore()));
  }

  static Future<void> AddTaskToFireStore(Task task,String Uid) {
    var collectionref = getTasksCollection(Uid);
    var taskref = collectionref.doc();
    task.id = taskref.id;
    return taskref.set(task);
  }

  static CollectionReference<Userr> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(Userr.collectionName)
        .withConverter<Userr>(
            fromFirestore: ((snapshot, options) =>
                Userr.fromJson(snapshot.data()!)),
            toFirestore: ((Userr, options) => Userr.ToFirestore()));
  }

  static Future<void> AddUserToFireStore(Userr user) {
    return getUsersCollection().doc(user.id).set(user);
  }

    static Future<Userr?> ReadUserFireStore(String Uid) async {
    var snapShot = await getUsersCollection().doc(Uid).get();
    return snapShot.data();
  }

  static Future<void> DeleteTaskFromFireStore(Task task,String Uid) {
    return getTasksCollection(Uid).doc(task.id).delete();
  }

  static Future<void> UpdateTaskFromFireStore(
      Task task, String editedTitle, String editedDesc,String Uid) {
    return getTasksCollection(Uid).doc(task.id).update({
      'title': editedTitle,
      'desc': editedDesc,
    });
  }

  static Future<void> UpdateIsDoneFireStore(Task task, bool isDone,String Uid) {
    return getTasksCollection(Uid).doc(task.id).update({'isDone': isDone});
  }


}
