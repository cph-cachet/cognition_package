part of cognition_package_model;

/// A Rapid Visual Information Proccesing Test
class RPRapidVisualInfoProcessingActivity extends RPActivityStep {
  RPRapidVisualInfoProcessingActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.interval = 9,
      this.lengthOfTest = 90,
      this.sequence = const [3, 6, 9]})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Interval in which numbers to display are picked (could be 9 (0-9)). Default is 9.
  int interval;

  /// Test duration in seconds. Default is 90 seconds
  int lengthOfTest;

  /// Sequence of numbers that is tracked. Default is 3,6,9
  List<int> sequence;

  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUIRapidVisualInfoProcessingActivityBody(
        this, eventLogger, onResultChange);
  }
}
