import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:research_package/research_package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'research_package_objects/survey_objects.dart';

import 'package:carp_core/carp_core.dart';
import 'package:carp_backend/carp_backend.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_webservices/carp_auth/carp_auth.dart';
import 'package:carp_webservices/carp_services/carp_services.dart';

// import 'package:carp_backend/carp_backend.dart';
// import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
// import 'package:carp_webservices/carp_services/carp_services.dart';
// import 'package:carp_webservices/carp_auth/carp_auth.dart';
// import 'package:carp_core/carp_core.dart';

CognitionDatum _$LightDatumFromJson(Map<String, dynamic> json) {
  return CognitionDatum(
    testResults: json['testResults'] as Object,
  )
    ..id = json['id'] as String
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String);
}

Map<String, dynamic> _$LightDatumToJson(CognitionDatum instance) {
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

class CognitionDatum extends Datum {
  @override
  DataFormat get format =>
      DataFormat.fromString('dk.cachet.carp.cognitiveAssessment');

  /// Intensity in Lux
  Object testResults;

  CognitionDatum({this.testResults}) : super(multiDatum: false);

  factory CognitionDatum.fromJson(Map<String, dynamic> json) =>
      _$LightDatumFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LightDatumToJson(this);

  @override
  String toString() => super.toString() + ', testResults: $testResults';
}

class SurveyPage extends StatelessWidget {
  final int age;
  final String name;
  final String location;
  final DateTime date;

  const SurveyPage({Key key, this.age, this.name, this.location, this.date})
      : super(key: key);

  initiateCARP(num age, String name, String location, DateTime date,
      RPTaskResult result, int finalScore) async {
    final String uri = dotenv.env['URI'];
    // print(uri);

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
    await CarpService().authenticate(
        username: dotenv.env['USERNAME'], password: dotenv.env['PASSWORD']);

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
    // print(invitations[0].invitation);
    // print(studyDeploymentId);

    //CarpService().app.studyDeploymentId = studyDeploymentId;
    CarpService().app.studyDeploymentId = dotenv.env['ID'];

    // -----------------------------------------------
    // EXAMPLE OF GETTING A STUDY PROTOCOL FROM CARP
    // -----------------------------------------------
    // create a CARP study manager and initialize it
    CarpStudyProtocolManager manager = CarpStudyProtocolManager();
    await manager.initialize();

    CognitionDatum datum = CognitionDatum(
      testResults: {
        'name: ': name,
        'age: ': age,
        'location: ': location,
        'date: ': date,
        'finalScore: ': finalScore,
        'testResults: ': result.results
      },
    );
    print('here you idiot wtf');
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

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  void resultCallback(RPTaskResult result) async {
    //printWrapped(_encode(result));
    int finalScore = 6;
    result.results.forEach((key, value) {
      print(key);
      value = value as RPActivityResult;
      print(value.results['result']['score']);
      finalScore += value.results['result']['score'];
    });
    print('finalScore: $finalScore');
    initiateCARP(age, name, location, date, result, finalScore);
    SharedPreferences sp = await SharedPreferences.getInstance();
    int attempts = sp.getInt('attempts');
    attempts += 1;
    sp.setInt('attempts', attempts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RPUITask(
      task: surveyTask,
      onSubmit: (result) {
        resultCallback(result);
      },
    ));
  }
}
