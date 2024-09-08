import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig extends ChangeNotifier {
  AppConfig(String apptheme,String applocale) {
    AppTheme = apptheme;
    Applanguge = applocale;
  }
  String? Applanguge;
  String? AppTheme;

  void changemode() async {
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{'repeat', 'Theme'},
      ),
    );

    String? Newtheme = prefsWithCache.getString('Theme')!;
    AppTheme = Newtheme;
    notifyListeners();
  }

  Future<String?> getmode() async {
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{'repeat', 'Theme'},
      ),
    );

    return prefsWithCache.getString('Theme')!;
    notifyListeners();
  }

  void changelanguge() async {
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{ 'locale'},
      ),
    );

    String? Newlocale = prefsWithCache.getString('locale')!;
    Applanguge = Newlocale;
    notifyListeners();
  }
}
