part of cognition_package_model;

/// A Flanker Test
@JsonSerializable()
class RPFlankerActivity extends RPActivityStep {
  /// Contructor for creating a Rapid Visual Information Processesing Test.
  RPFlankerActivity(
    String identifier, {
    includeInstructions = true,
    includeResults = true,
    // this.interval = 9,
    this.lengthOfTest = 90,
    this.numberOfCards = 25,
    // this.sequence = const [3, 6, 9]
  }) : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  /// Number of cards to be presented. Default is 25
  int numberOfCards;

  /// override the activitybody with the UI body of the test
  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUIFlankerActivityBody(this, eventLogger, onResultChange);
  }

  /// override the AcitivityResult with the results calculation of the test
  /// this is called when the test is finished
  /// result is the number of mistakes made during the test
  /// if the number of mistakes > 2, the test is failed and a score of 0 is returned
  /// else a score of 1 is returned
  @override
  calculateScore(dynamic result) {
    var sum = 1;
    if (result['mistakes'] > 2) {
      sum = 0;
    }
    print('flanker score: ' + sum.toString());
    return sum;
  }
}
