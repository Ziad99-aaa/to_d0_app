import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_d0_app/home.dart';
import 'package:to_d0_app/my_theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_d0_app/pages/login_Screen.dart';
import 'package:to_d0_app/pages/register_Screen.dart';
import 'package:to_d0_app/providers/USer_Provider.dart';
import 'package:to_d0_app/providers/app_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_d0_app/providers/listProviders.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{'repeat', 'Theme'},
      ),
    );

    String? Newtheme = prefsWithCache.getString('Theme')!;


     WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferencesWithCache prefssWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{'locale'},
      ),
    );

    String? Newlocale = prefssWithCache.getString('locale')!;


  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
// Replace with actual values
          options: const FirebaseOptions(
            apiKey: "AIzaSyB7m5XDKTnOs_2gxmfZLcS9AWAXCCEKXCY",
            appId: "com.example.to_d0_app",
            messagingSenderId: "1007475431129",
            projectId: "to-do-app-bc6f3",
          ),
        )
      : await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppConfig(Newtheme,Newlocale)),
    ChangeNotifierProvider(create: (context) => ListProvidder()),
    ChangeNotifierProvider(create: (context) => UserProvider())
  ], child: MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<AppConfig>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: loginScreen.routName,
      routes: {
        RegisterScreen.routName: (context) => RegisterScreen(),
        loginScreen.routName: (context) => loginScreen(),
        Home.routName: (context) => Home(),
      },
      theme: MtTheme.themelight,
      darkTheme: MtTheme.themedark,
      themeMode: provider.AppTheme == 'dark' ? ThemeMode.dark : ThemeMode.light,
      locale: provider.Applanguge=="en"?Locale("en") :Locale("amr"),
    );
  }

  
}
