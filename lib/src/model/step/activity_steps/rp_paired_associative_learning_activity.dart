part of cognition_package_model;

/// A Paired Associates Learning Test
@JsonSerializable()
class RPPairedAssociatesLearningActivity extends RPActivityStep {
  /// Contructor for creating a Paired Associates Learning Test.
  RPPairedAssociatesLearningActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.maxTestDuration = 100})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// The maximum length of the test. Default is 100 seconds
  int maxTestDuration;

  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUIPairedAssociatesLearningActivityBody(
        this, eventLogger, onResultChange);
  }
}
