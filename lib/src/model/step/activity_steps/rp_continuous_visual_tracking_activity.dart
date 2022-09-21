part of cognition_package_model;

/// A Multiple Object Tracking Test
class RPContinuousVisualTrackingActivity extends RPActivityStep {
  RPContinuousVisualTrackingActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.lengthOfTest = 90,
      this.numberOfTests = 3,
      this.amountOfDots = 5,
      this.amountOfTargets = 2,
      this.dotSize = 100,
      this.trackingSpeed = const Duration(seconds: 5)
      // this.sequence = const [3, 6, 9]
      })
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  /// Amount of test repetitions. Default is 3
  int numberOfTests;

  /// Amount of dots to be displayed. Default is 5
  int amountOfDots;

  int amountOfTargets;

  /// Size of the dots in pixels. Default is 100
  int dotSize;

  /// the speed of the dots in seconds. Default is 5 seconds per move
  Duration trackingSpeed;

  /// override the activitybody with the UI body of the test
  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUIContinuousVisualTrackingActivityBody(
        this, eventLogger, onResultChange);
  }

  /// override the AcitivityResult with the results calculation of the test
  /// this is called when the test is finished
  /// the result is a list of mistakes for each test repetition
  /// the list is empty if no mistakes were made
  /// for every repetition with 0 mistakes a score of 1 is added
  /// the sum of repetitions with 0 mistakes is the final score
  @override
  calculateScore(dynamic result) {
    var sum = -1;
    List<int> mistakes = result['mistakes'];
    for (var round in mistakes) {
      if (round < amountOfTargets) {
        sum += 1;
      }
    }
    return sum;
  }
}
