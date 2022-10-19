part of cognition_package_model;

/// Delayed Recall Test.
/// Must be used after a [RPWordRecallActivity]
class RPDelayedRecallActivity extends RPWordRecallActivity {
  RPDelayedRecallActivity({
    required super.identifier,
    super.includeInstructions,
    super.includeResults,
    super.lengthOfTest,
    super.numberOfTests,
  });

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUIDelayedRecallActivityBody(this, eventLogger, onResultChange);
}
