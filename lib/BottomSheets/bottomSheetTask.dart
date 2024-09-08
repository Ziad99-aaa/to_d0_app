import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_d0_app/FireStore.dart';
import 'package:to_d0_app/Task.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/providers/USer_Provider.dart';
import 'package:to_d0_app/providers/app_config.dart';
import 'package:to_d0_app/providers/listProviders.dart';

class bottomSheetmTask extends StatefulWidget {
  const bottomSheetmTask({super.key});

  @override
  State<bottomSheetmTask> createState() => _BottomsheetlangugeState();
}

class _BottomsheetlangugeState extends State<bottomSheetmTask> {
  static final _formKey = GlobalKey<FormState>();
  String title = "";
  String dic = "";
  var selectDate = DateTime.now();
  late ListProvidder listprovider;
  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvidder>(context);
          var Userprovider = Provider.of<UserProvider>(context);
    var provider = Provider.of<AppConfig>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Add new Task',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (text) {
                    title = text;
                  },
                  style: TextStyle(color: AppColor.blackcolor),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "please enter task title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'enter task title',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey, fontSize: 20),
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (text) {
                    dic = text;
                  },
                  style: TextStyle(color: AppColor.blackcolor),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "please enter task description";
                    }
                    return null;
                  },
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: AppColor.blackcolor),
                    hintText: 'enter task description',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey, fontSize: 20),
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    ShowCalender();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Select time',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 20.0),
                Text(
                  '${selectDate.day}/${selectDate.month}/${selectDate.year}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey, fontSize: 20),
                ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      Task task =
                          Task(title: title, desc: dic, date: selectDate);
                      Firestore.AddTaskToFireStore(task,Userprovider.currentUser!.id)
                          .timeout(Duration(milliseconds: 1), onTimeout: () {
                        listprovider.getAllTasksFromFireStore(Userprovider.currentUser!.id);
                        print("task adedd");
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Add",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ShowCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 360)),
        initialDate: DateTime.now());
    selectDate = chosenDate ?? DateTime.now();
  }
}
