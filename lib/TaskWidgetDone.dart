import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_d0_app/FireStore.dart';
import 'package:to_d0_app/Task.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/providers/USer_Provider.dart';
import 'package:to_d0_app/providers/app_config.dart';
import 'package:to_d0_app/providers/listProviders.dart';

class TaskWidgetDone extends StatelessWidget {
  static final formKey = GlobalKey<FormState>();
  bool isDone = true;
  var selectDate = DateTime.now();
  static String editedTitle = '';
  static String editedDesc = '';

  late ListProvidder listprovider;
  Task task;
  TaskWidgetDone({required this.task});
  @override
  Widget build(BuildContext context) {
          var Userprovider = Provider.of<UserProvider>(context);
    var listprovider = Provider.of<ListProvidder>(context);
    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        extentRatio: .50,
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            borderRadius: BorderRadius.circular(30),
            onPressed: (context) {
              Firestore.DeleteTaskFromFireStore(task,Userprovider.currentUser!.id)
                  .timeout(Duration(milliseconds: 1), onTimeout: () {
                print("is deleted");
                listprovider.getAllTasksFromFireStore(Userprovider.currentUser!.id);
              });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(30),
            onPressed: (context) {
              showEditTaskDialog(context);
            },
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'edit',
          ),
        ],
      ),

      child: Container(
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.whitecolor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 4.0,
                  height: 40.0,
                  color: AppColor.greencolor,
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackcolor,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      task.desc,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackcolor,
                      ),
                    ),
                    SizedBox(height: 4.0),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Firestore.UpdateIsDoneFireStore(task, false,Userprovider.currentUser!.id);
                listprovider.getAllTasksFromFireStore(Userprovider.currentUser!.id);
              },
              child: Container(
                width: 50,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColor.greencolor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showEditTaskDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Edit Task',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "please edit task title";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      editedTitle = text;
                    },
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                      labelText: 'Edit title',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "please edit task Description";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      editedDesc = text;
                    },
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                      labelText: 'Edit Description',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        
                        // Handle save changes here
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text('Save Changes',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColor.blackcolor,
                            )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
