part of cognition_package_model;

/// A Picture Sequence Memory Test
@JsonSerializable()
class RPPictureSequenceMemoryActivity extends RPActivityStep {
  /// Contructor for creating a Rapid Visual Information Processesing Test.
  RPPictureSequenceMemoryActivity(
    String identifier, {
    includeInstructions = true,
    includeResults = true,
    // this.interval = 9,
    this.lengthOfTest = 90,
    this.numberOfTests = 3,
    this.numberOfPics = 3,
    // this.sequence = const [3, 6, 9]
  }) : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  /// Number of tests to be performed. Default is 3
  int numberOfTests;

  /// Number of pictures to be displayed. Default is 3
  int numberOfPics;

  /// override the activitybody with the UI body of the test
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
    print('picture sequence memory score: ' + sum.toString());
    return sum;
  }
}
