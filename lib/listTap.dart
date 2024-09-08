import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:to_d0_app/FireStore.dart';
import 'package:to_d0_app/Task.dart';
import 'package:to_d0_app/TaskWidget.dart';
import 'package:to_d0_app/TaskWidgetDone.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/providers/USer_Provider.dart';
import 'package:to_d0_app/providers/app_config.dart';
import 'package:to_d0_app/providers/listProviders.dart';

class ListTap extends StatefulWidget {
  const ListTap({super.key});

  @override
  State<ListTap> createState() => _SettingState();
}

class _SettingState extends State<ListTap> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ListProvidder>(context);
    var Userprovider = Provider.of<UserProvider>(context);
    var Appprovider = Provider.of<AppConfig>(context);


    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            locale: Appprovider.Applanguge!,
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              provider.changeDate(selectedDate, Userprovider.currentUser!.id);
              provider.getAllTasksFromFireStore(Userprovider.currentUser!.id);
              //`selectedDate` the new date selected.
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNumMonth,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color.fromARGB(255, 221, 19, 19),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: provider.tasksList.isEmpty
                ? 
                
                Center(
                    child: Text("Empty",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColor.blackcolor,
                            )),
                  )
                : ListView.builder(
                    itemCount: provider.tasksList.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return provider.tasksList[index].isDone == true
                          ? TaskWidgetDone(task: provider.tasksList[index])
                          : TaskWidget(task: provider.tasksList[index]);
                    },
                  ),
          )
        ],
      ),
    );
  }
}
