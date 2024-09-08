import 'package:flutter/material.dart';
import 'package:to_d0_app/FireStore.dart';
import 'package:to_d0_app/Task.dart';

class ListProvidder extends ChangeNotifier {

    bool isDone = false;
    
  void changeIsDone() {
    isDone = !isDone;
    notifyListeners();
  }


  List<Task> tasksList = [];

  DateTime datee = DateTime.now();

  void changeDate(DateTime date,String Uid) {
    datee = date;
    getAllTasksFromFireStore(Uid);
  }

  void getAllTasksFromFireStore(String Uid) async {
    var quarySnapShot = await Firestore.getTasksCollection(Uid)
        .where('date', isEqualTo: datee.millisecondsSinceEpoch)
        .get();
    tasksList = quarySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();

    tasksList.sort((task1, task2) {
      return task1.date.compareTo(task2.date);
    });
    notifyListeners();
  }
}
