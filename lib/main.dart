import 'package:flutter/material.dart';
import 'package:flutter_localization_example/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // AppLocalizations import edilmelidir

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = const Locale('en'); //default language code

  void _changeLocale(Locale newLocale) {
    //language change function
    setState(() {
      _currentLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: L10n.all,
      locale: _currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(
        changeLocale: _changeLocale,
        currentLocale: _currentLocale,
      ),
    );
  }
}

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final Function(Locale) changeLocale; // local change function
  Locale currentLocale;
  HomePage(
      {super.key, required this.currentLocale, required this.changeLocale});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        AppLocalizations.of(context)!.appbar_text,
      )),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(//Hello text
              '${AppLocalizations.of(context)!.hello},',
              style: const TextStyle(
                  color: Color.fromARGB(255, 5, 13, 130),
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            Text(//Welcome message
              AppLocalizations.of(context)!.welcome,
              style: const TextStyle(
                  color: Color.fromARGB(255, 5, 13, 130),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,

                  fontSize: 26),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.t1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              AppLocalizations.of(context)!.text_description,
              style: const TextStyle(fontSize: 14),
            ),
            const Spacer(),
            Container(//Change Langage Switch Button
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 5, 13, 130),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.choose_language,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Switch(
                      activeColor: const Color.fromARGB(255, 11, 23, 192),
                      activeTrackColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      value: widget.currentLocale.languageCode ==
                          'tr', // Is is turkish?
                      onChanged: (value) {
                        if (value) {
                          widget.changeLocale(const Locale('tr')); // Turkish
                        } else {
                          widget.changeLocale(const Locale('en')); // English
                        }
                      }),
                ],
              ),
            ),
            Text(//Language text
              AppLocalizations.of(context)!.language,
            ),
          ],
        ),
      ),
    );
  }
}
