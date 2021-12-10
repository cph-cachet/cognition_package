import 'package:flutter/material.dart';
import 'package:research_package_demo_app/user_demographics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:carp_core/carp_core.dart';
import 'package:carp_backend/carp_backend.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_webservices/carp_auth/carp_auth.dart';
import 'package:carp_webservices/carp_services/carp_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          primaryColor: Color(0xffC32C39),
          accentColor: Color(0xff003F6E),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Color(0xffC32C39);
            else if (states.contains(MaterialState.disabled))
              return Colors.grey.withOpacity(0.5);
            return Color(0xffC32C39); // Use the component's default.
            // foregroundColor: MaterialStateProperty.resolveWith<Color>(
            //     (states) => Colors.white),
            // backgroundColor: MaterialStateProperty.resolveWith<Color>(
            //     (states) => Color(0xff003F6E)),
          })))),
      title: 'Research Package Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

cognitionDatum _$LightDatumFromJson(Map<String, dynamic> json) {
  return cognitionDatum(
    testResults: json['testResults'] as Object,
  )
    ..id = json['id'] as String
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String);
}

Map<String, dynamic> _$LightDatumToJson(cognitionDatum instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  writeNotNull('testResults', instance.testResults);
  return val;
}

class cognitionDatum extends Datum {
  DataFormat get format =>
      DataFormat.fromString('dk.cachet.carp.cognitiveAssessment');

  /// Intensity in Lux
  Object testResults;

  cognitionDatum({this.testResults}) : super(multiDatum: false);

  factory cognitionDatum.fromJson(Map<String, dynamic> json) =>
      _$LightDatumFromJson(json);
  Map<String, dynamic> toJson() => _$LightDatumToJson(this);

  String toString() => super.toString() + ', testResults: $testResults';
}

class _MyHomePageState extends State<MyHomePage> {
  bool fireBase = false;
  bool buttonReady = true;

  initiateCARP() async {
    final String uri = "https://cans.cachet.dk/";

    // configure an app that points to the CARP web service
    CarpApp app = CarpApp(
      name: 'cognition_package_testing',
      uri: Uri.parse(uri),
      oauth: OAuthEndPoint(
        clientID: 'carp',
        clientSecret: 'carp',
      ),
    );

    // configure the CARP service
    CarpService().configure(app);

    // authenticate at CARP
    await CarpService()
        .authenticate(username: 'ossi0004@gmail.com', password: 'UKU76rdm');

    final currentuser = await CarpService().getCurrentUserProfile();
    print(currentuser.accountId);

    // configure the other services needed
    CarpParticipationService().configureFrom(CarpService());
    CarpDeploymentService().configureFrom(CarpService());

    // get the invitations to studies from CARP for this user
    List<ActiveParticipationInvitation> invitations =
        await CarpParticipationService().getActiveParticipationInvitations();

    // use the first (i.e. latest) invitation
    String studyDeploymentId = invitations[0].studyDeploymentId;
    print(invitations[0].invitation);
    print(studyDeploymentId);

    CarpService().app.studyDeploymentId = studyDeploymentId;

    // -----------------------------------------------
    // EXAMPLE OF GETTING A STUDY PROTOCOL FROM CARP
    // -----------------------------------------------

    // create a CARP study manager and initialize it
    CarpStudyProtocolManager manager = CarpStudyProtocolManager();
    await manager.initialize();

    cognitionDatum datum = cognitionDatum(
      testResults: {'test1 score: ': 12345},
    );

    // create a CARP data point
    final DataPoint data = DataPoint.fromData(datum)
      ..carpHeader.studyId = studyDeploymentId
      ..carpHeader.userId = currentuser.accountId;
    print(app.studyDeploymentId);
    print(CarpService().app.studyDeploymentId);
    // post it to the CARP server, which returns the ID of the data point
    int dataPointId =
        await CarpService().getDataPointReference().postDataPoint(data);

    print(dataPointId);
  }

  @override
  void initState() {
    super.initState();
    controlID();
    // initiateCARP();
  }

  void controlID() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('ID')) {
      sp.setString('ID', Uuid().v4());
      sp.setInt('attempts', 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Cognitive Testing App Alpha"),
      // ),
      backgroundColor: Color(0xff003F6E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 150),
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
                      "Welcome to the alpha-testing of cognitive tests Package, developed by Ossi Kallunki",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Container(height: 50),
                    Text(
                      "If you have any issues or questions feel free to contact us at",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Container(height: 5),
                    Text(
                      "ossi0004@gmail.com",
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
              padding: const EdgeInsets.only(top: 150),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffC32C39),
                  fixedSize: const Size(300, 60),
                ),
                child: Text(
                  "Get started",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
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
          "assets/images/Cachet-logo-white.png",
          height: 50,
        ),
      )),
    );
  }

  Widget _getIcon() {
    if (fireBase) {
      return Icon(Icons.check, size: 18);
    } else {
      return Icon(Icons.whatshot, size: 18);
    }
  }
}
