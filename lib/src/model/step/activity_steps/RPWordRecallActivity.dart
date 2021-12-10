part of cognition_package_model;

/// A Verbal Recognition memory Test
@JsonSerializable()
class RPWordRecallActivity extends RPActivityStep {
  /// Contructor for creating a Rapid Visual Information Processesing Test.
  RPWordRecallActivity(
    String identifier, {
    includeInstructions = true,
    includeResults = true,
    // this.interval = 9,
    this.lengthOfTest = 90,
    this.numberOfTests = 3,
    // this.numberOfPics = 3,
    // this.sequence = const [3, 6, 9]
  }) : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  /// Number of tests to be performed. Default is 3
  int numberOfTests;

  /// override the activitybody with the UI body of the test
  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUIWordRecallActivityBody(this, eventLogger, onResultChange);
  }

  /// override the AcitivityResult with the results calculation of the test
  /// this is called when the test is finished
  /// result is calculated the same as for delayed recall
  /// but 0 is returned as per MOCA standards.
  /// score is calculated in Delayed Recall Activity
  @override
  calculateScore(dynamic result) {
    List<String> wordList = result["wordsList"];
    List<String> resultsList = result["resultsList"];
    resultsList = resultsList.map((result) => result.toLowerCase()).toList();
    var sum = 0;
    for (int i = 0; i < resultsList.length; i++) {
      if (wordList.contains(resultsList[i])) {
        sum++;
      }
    }
    print('Word Recall score: ' + sum.toString());
    return 0;
  }
}
