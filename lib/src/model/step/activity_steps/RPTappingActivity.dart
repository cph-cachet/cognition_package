part of cognition_package_model;

/// A Tapping Test
@JsonSerializable()
class RPTappingActivity extends RPActivityStep {
  /// Contructor for creating a Tapping Test.
  RPTappingActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.lengthOfTest = 30})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// Test length in seconds. Default is 30 seconds.
  int lengthOfTest;

  @override
  Widget stepBody(Function onResultChange, RPActivityEventLogger eventLogger) {
    return RPUITappingActivityBody(this, eventLogger, onResultChange());
  }
}
