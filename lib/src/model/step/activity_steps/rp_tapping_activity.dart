part of cognition_package_model;

/// Tapping Test.
class RPTappingActivity extends RPActivityStep {
  /// Contructor for creating a Tapping Test.
  RPTappingActivity(
      {required super.identifier,
      super.includeInstructions,
      super.includeResults,
      this.lengthOfTest = 30});

  /// Test length in seconds. Default is 30 seconds.
  int lengthOfTest;

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUITappingActivityBody(this, eventLogger, onResultChange);
}
