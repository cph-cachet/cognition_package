part of cognition_package_model;

/// A Verbal Recognition memory Test
class RPWordRecallActivity extends RPActivityStep {
  RPWordRecallActivity({
    required super.identifier,
    super.includeInstructions,
    super.includeResults,
    this.lengthOfTest = 90,
    this.numberOfTests = 3,
  });

  /// Test duration in seconds. Default is 90 seconds.
  int lengthOfTest;

  /// Number of tests to be performed. Default is 3.
  int numberOfTests;

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUIWordRecallActivityBody(this, eventLogger, onResultChange);

  /// Score is the sum of correct answers in the list of results that
  /// match the words in the list of words.
  @override
  int calculateScore(dynamic result) {
    int sum = 0;
    try {
      List<String> wordList = result['wordsList'] as List<String>;
      List<String> resultsList = result['resultsList'] as List<String>;
      resultsList = resultsList.map((result) => result.toLowerCase()).toList();
      for (int i = 0; i < resultsList.length; i++) {
        if (wordList.contains(resultsList[i])) sum++;
      }
    } catch (error) {
      print('$runtimeType - $error');
    }
    return sum;
  }
}
