import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/providers/app_config.dart';

class bottomSheetmode extends StatefulWidget {
  const bottomSheetmode({super.key});

  @override
  State<bottomSheetmode> createState() => _bottomSheetmodeState();
}

class _bottomSheetmodeState extends State<bottomSheetmode> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () async {
                final SharedPreferencesWithCache prefsWithCache =
                    await SharedPreferencesWithCache.create(
                  cacheOptions: const SharedPreferencesWithCacheOptions(
                    // When an allowlist is included, any keys that aren't included cannot be used.
                    allowList: <String>{'repeat', 'Theme'},
                  ),
                );
                await prefsWithCache.setString('Theme', 'light');
                provider.changemode();
              },
              child: provider.AppTheme == 'light'
                  ? getSelecteditemWidget(AppLocalizations.of(context)!.light)
                  : getUnSelecteditemWidget(
                      AppLocalizations.of(context)!.light)),
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () async {
                final SharedPreferencesWithCache prefsWithCache =
                    await SharedPreferencesWithCache.create(
                  cacheOptions: const SharedPreferencesWithCacheOptions(
                    // When an allowlist is included, any keys that aren't included cannot be used.
                    allowList: <String>{'repeat', 'Theme'},
                  ),
                );
                await prefsWithCache.setString('Theme', 'dark');
                provider.changemode();
              },
              child: provider.AppTheme == "dark"
                  ? getSelecteditemWidget(AppLocalizations.of(context)!.dark)
                  : getUnSelecteditemWidget(
                      AppLocalizations.of(context)!.dark)),
        ],
      ),
    );
  }

  Widget getSelecteditemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColor.primarycolor),
        ),
        Icon(Icons.check, color: AppColor.primarycolor)
      ],
    );
  }

  Widget getUnSelecteditemWidget(String text) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}
