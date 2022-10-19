part of cognition_package_model;

/// Corsi Block Tapping Test.
class RPCorsiBlockTappingActivity extends RPActivityStep {
  /// Create Corsi Block Tapping Test.
  RPCorsiBlockTappingActivity({
    required super.identifier,
    super.includeInstructions,
    super.includeResults,
  });

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUICorsiBlockTappingActivityBody(this, eventLogger, onResultChange);
}
