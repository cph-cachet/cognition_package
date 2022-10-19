part of cognition_package_model;

/// Reaction Time Test.
class RPReactionTimeActivity extends RPActivityStep {
  /// Contructor for creating a Reaction time Test.
  RPReactionTimeActivity(
      {required super.identifier,
      super.includeInstructions,
      super.includeResults,
      this.lengthOfTest = 30,
      this.switchInterval = 4});

  /// The duration of the test. Default is 30 seconds.
  int lengthOfTest;

  /// Max seconds until light switch-1. Writing 4 means at most 5 seconds.
  /// Default is 4.
  int switchInterval;

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUIReactionTimeActivityBody(this, eventLogger, onResultChange);
}
