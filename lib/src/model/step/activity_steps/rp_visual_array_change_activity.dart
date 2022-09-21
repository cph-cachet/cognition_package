part of cognition_package_model;

/// Visual Array Change Test
class RPVisualArrayChangeActivity extends RPActivityStep {
  RPVisualArrayChangeActivity(
    String identifier, {
    includeInstructions = true,
    includeResults = true,
    this.numberOfShapes = 3,
    this.lengthOfTest = 90,
    this.waitTime = 2,
    this.numberOfTests = 3,
  }) : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  /// number of tests to run. Default is 3
  int numberOfTests;

  int numberOfShapes;

  /// wait time between tests in seconds. Default is 2 seconds
  int waitTime;

  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUIVisualArrayChangeActivityBody(this, eventLogger, onResultChange);
  }

  /// override the AcitivityResult with the results calculation of the test
  /// this is called when the test is finished
  /// number of correct answers is the number of correct answers in the test
  @override
  calculateScore(dynamic result) {
    var sum = result['correct'];
    return sum;
  }
}
