import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'splash&onboarding_pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final pref = await SharedPreferences.getInstance();
  bool isArabic = pref.getBool("language") ?? false;

  runApp(
    MyApp(
      startLocale: Locale(isArabic ? 'ar' : 'en'),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Locale startLocale;

  const MyApp({
    super.key,
    required this.startLocale,
  });

  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.startLocale;
  }

  Future<void> changeLanguage() async {
    final pref = await SharedPreferences.getInstance();

    if (_locale.languageCode == "en") {
      await pref.setBool("language", true);

      setState(() {
        _locale = const Locale("ar");
      });
    } else {
      await pref.setBool("language", false);

      setState(() {
        _locale = const Locale("en");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}