import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/providers/app_config.dart';

class Bottomsheetlanguge extends StatefulWidget {
  const Bottomsheetlanguge({super.key});

  @override
  State<Bottomsheetlanguge> createState() => _BottomsheetlangugeState();
}

class _BottomsheetlangugeState extends State<Bottomsheetlanguge> {
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
                    allowList: <String>{'locale'},
                  ),
                );

                await prefsWithCache.setString('locale', 'en');

                provider.changelanguge();
              },
              child: provider.Applanguge == "en"
                  ? getSelecteditemWidget(AppLocalizations.of(context)!.english)
                  : getUnSelecteditemWidget(
                      AppLocalizations.of(context)!.english)),
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () async{
                final SharedPreferencesWithCache prefsWithCache =
                    await SharedPreferencesWithCache.create(
                  cacheOptions: const SharedPreferencesWithCacheOptions(
                    // When an allowlist is included, any keys that aren't included cannot be used.
                    allowList: <String>{'locale'},
                  ),
                );

                await prefsWithCache.setString('locale', 'ar');

                provider.changelanguge();
              },
              child: provider.Applanguge == "ar"
                  ? getSelecteditemWidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelecteditemWidget(
                      AppLocalizations.of(context)!.arabic)),
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
        Icon(
          Icons.check,
          color: AppColor.primarycolor,
        )
      ],
    );
  }

  Widget getUnSelecteditemWidget(String text) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}
