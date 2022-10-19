part of cognition_package_model;

/// A Paired Associates Learning Test
class RPPairedAssociatesLearningActivity extends RPActivityStep {
  /// Contructor for creating a Paired Associates Learning Test.
  RPPairedAssociatesLearningActivity({
    required super.identifier,
    super.includeInstructions,
    super.includeResults,
    this.maxTestDuration = 100,
  });

  /// The maximum length of the test. Default is 100 seconds.
  int maxTestDuration;

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUIPairedAssociatesLearningActivityBody(
          this, eventLogger, onResultChange);
}
