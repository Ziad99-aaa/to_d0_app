import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_d0_app/BottomSheets/bottomSheetTask.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/listTap.dart';
import 'package:to_d0_app/pages/login_Screen.dart';
import 'package:to_d0_app/providers/USer_Provider.dart';
import 'package:to_d0_app/providers/listProviders.dart';
import 'package:to_d0_app/pages/setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  static const String routName = "home_screen";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selecedindex = 0;
  @override
  Widget build(BuildContext context) {
    var Userprovider = Provider.of<UserProvider>(context);
    var Listprovider = Provider.of<ListProvidder>(context);
    Listprovider.getAllTasksFromFireStore(Userprovider.currentUser!.id);

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(0, 0, 0, 0)),
              onPressed: () {
                Listprovider.tasksList = [];
                Navigator.pushReplacementNamed(context, loginScreen.routName);
              },
              child: Icon(
                Icons.login,
                color: AppColor.whitecolor,
              ))
        ],
        toolbarHeight: MediaQuery.of(context).size.height * .19,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.app_title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "( ${Userprovider.currentUser!.name} )",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColor.whitecolor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              selecedindex = index;
            });
          },
          currentIndex: selecedindex, // Update this to use the selected index
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icon_list.png")),
                label: AppLocalizations.of(context)!.task_list),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icon_settings.png")),
                label: AppLocalizations.of(context)!.setting),
          ]),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: AppColor.whitecolor, width: 3)),
        onPressed: () {
          ShowBottomSheetTask();
        },
        child: Icon(
          Icons.add,
          color: AppColor.whitecolor,
        ),
        backgroundColor: AppColor.primarycolor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selecedindex == 0 ? ListTap() : Setting(),
    );
  }

  void ShowBottomSheetTask() {
    showModalBottomSheet(
        context: context, builder: (context) => bottomSheetmTask());
  }
}
