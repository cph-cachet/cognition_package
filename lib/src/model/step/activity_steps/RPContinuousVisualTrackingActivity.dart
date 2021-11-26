part of cognition_package_model;

/// A Rapid Visual Information Proccesing Test
@JsonSerializable()
class RPContinuousVisualTrackingActivity extends RPActivityStep {
  /// Contructor for creating a Rapid Visual Information Processesing Test.
  RPContinuousVisualTrackingActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.interval = 9,
      this.lengthOfTest = 90,
      this.numberOfTests = 3,
      this.amountOfDots = 5,
      this.dotSize = 100,
      this.trackingSpeed = const Duration(seconds: 5),
      this.sequence = const [3, 6, 9]})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Interval in which numbers to display are picked (could be 9 (0-9)). Default is 9.
  int interval;

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  int numberOfTests;

  int amountOfDots;

  int dotSize;

  Duration trackingSpeed;

  /// Sequence of numbers that is tracked. Default is 3,6,9
  List<int> sequence;

  @override
  Widget stepBody(Function onResultChange, RPActivityEventLogger eventLogger) {
    return RPUIContinuousVisualTrackingActivityBody(
        this, eventLogger, onResultChange());
  }
}
