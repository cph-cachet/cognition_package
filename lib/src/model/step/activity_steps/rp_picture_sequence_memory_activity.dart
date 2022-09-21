part of cognition_package_model;

/// Picture Sequence Memory Test
class RPPictureSequenceMemoryActivity extends RPActivityStep {
  RPPictureSequenceMemoryActivity(
    String identifier, {
    includeInstructions = true,
    includeResults = true,
    this.lengthOfTest = 90,
    this.numberOfTests = 3,
    this.numberOfPics = 3,
  }) : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  /// Number of tests to be performed. Default is 3
  int numberOfTests;

  /// Number of pictures to be displayed. Default is 3
  int numberOfPics;

  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUIPictureSequenceMemoryActivityBody(
        this, eventLogger, onResultChange);
  }

  /// override the AcitivityResult with the results calculation of the test
  /// this is called when the test is finished
  /// [results] is the list of pairs correcly placed in the test
  /// return sum of correctly placed pairs
  @override
  calculateScore(dynamic result) {
    var sum = 0;
    List<dynamic> pairs = result['pairs'];
    for (int pair in pairs) {
      sum += pair;
    }
    return sum;
  }
}
