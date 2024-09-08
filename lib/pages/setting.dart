import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/BottomSheets/bottomSheetLanguge.dart';
import 'package:to_d0_app/BottomSheets/bottomSheetmode.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_d0_app/providers/app_config.dart';

class Setting extends StatefulWidget {


  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.languge,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.blackcolor,
                  )),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showlangugebottomsheet();
            },
            child: Container(
              padding: EdgeInsets.all(20),
              color: AppColor.whitecolor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.Applanguge == "en"
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_circle_down_rounded)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.blackcolor,
                  )),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showbottomsheetmode();
            },
            child: Container(
              padding: EdgeInsets.all(20),
              color: AppColor.whitecolor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.AppTheme == 'light'
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_circle_down_rounded)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  void showlangugebottomsheet() {
    showModalBottomSheet(
        context: context, builder: (context) => Bottomsheetlanguge());
  }

  void showbottomsheetmode() {
    showModalBottomSheet(
        context: context, builder: (context) => bottomSheetmode());
  }
}
