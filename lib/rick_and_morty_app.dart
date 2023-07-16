import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/navigation/app_router.dart';
import 'package:rick_and_morty/navigation/generate_navigator.dart';
import 'package:rick_and_morty/pages/home_page/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'assets/color_schemes.g.dart';

class RickAndMortyApp extends StatelessWidget {
  RickAndMortyApp({super.key});

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router.config(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ru'), // RUSSIAN
      ],
    );
  }
}
