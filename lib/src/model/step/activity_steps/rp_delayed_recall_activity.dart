part of cognition_package_model;

/// Delayed Recall Test.
/// Must be used after a [RPWordRecallActivity]
class RPDelayedRecallActivity extends RPActivityStep {
  RPDelayedRecallActivity(
    String identifier, {
    includeInstructions = true,
    includeResults = true,
    // this.interval = 9,
    this.lengthOfTest = 90,
    this.numberOfTests = 3,
    // this.sequence = const [3, 6, 9]
  }) : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  /// Number of tests to be performed. Default is 3.
  int numberOfTests;

  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUIDelayedRecallActivityBody(this, eventLogger, onResultChange);
  }

  /// override the AcitivityResult with the results calculation of the test
  /// this is called when the test is finished
  /// [results] is a list of the results of each test
  /// score is the sum of correct answers in the resultList that match the words in wordList
  @override
  calculateScore(dynamic result) {
    List<String> wordList = result['wordsList'];
    List<String> resultsList = result['resultsList'];
    resultsList = resultsList.map((result) => result.toLowerCase()).toList();
    var sum = 0;
    for (int i = 0; i < resultsList.length; i++) {
      if (wordList.contains(resultsList[i])) {
        sum++;
      }
    }
    return sum;
  }
}
