part of cognition_package_model;

/// A Corsi Block Tapping Test
@JsonSerializable()
class RPCorsiBlockTappingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  /// Must contain an identifier for storing purposes
  RPCorsiBlockTappingActivity(String identifier,
      {includeInstructions = true, includeResults = true})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUICorsiBlockTappingActivityBody(this, eventLogger, onResultChange);
  }
}
