import 'package:research_package/research_package.dart';
import 'package:cognition_package/cognition_package.dart';
import 'package:flutter/material.dart';
import 'package:cognition_package_demo_app/user_demographics_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  // Initialize cognition package.
  // Needed if you load a cognition configuration from a json file
  CognitionPackage.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en'),
        Locale('da'),
        Locale('fr'),
        Locale('pt'),
      ],
      localizationsDelegates: [
        // Research Package (RP) and Cognition Package (CP) translations.
        // Supports translation of both the RP and CP specific text as well as
        // app-specific text.
        // Read more about localization at https://carp.cachet.dk/localization/
        RPLocalizations.delegate,
        CPLocalizations.delegate,

        // Built-in localization of basic text for Cupertino widgets
        GlobalCupertinoLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode) {
            return supportedLocale;
          }
        }
        // if the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: 'Cognition Package Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var locale = RPLocalizations.of(context);

    return Scaffold(
      backgroundColor: Color(0xff003F6E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 50),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Image.asset(
                "assets/images/mcat-logo.png",
                height: 80,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Column(
                  children: <Widget>[
                    Text(
                      locale?.translate("home.welcome") ?? "Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Container(height: 5),
                    Text(
                      locale?.translate("home.questions") ?? "Questions?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Container(height: 5),
                    Text(
                      "cph_cachet@gmail.com",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                    //Container(height: 50),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffC32C39),
                  fixedSize: const Size(300, 60),
                ),
                child: Text(
                  locale?.translate("home.start") ?? "Get started",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (context) => UserDemographicsPage()));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Image.asset(
          "assets/images/cachet-logo-white.png",
          height: 50,
        ),
      )),
    );
  }
}
