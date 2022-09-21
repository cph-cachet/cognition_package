part of cognition_package_model;

/// Letter Tapping Test
class RPLetterTappingActivity extends RPActivityStep {
  /// Contructor for creating a Letter Tapping Test.
  RPLetterTappingActivity(String identifier,
      {includeInstructions = true, includeResults = true})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUILetterTappingActivityBody(this, eventLogger, onResultChange);
  }

  @override
  calculateScore(dynamic result) {
    var errors = result['errors'];
    int score = errors < 2 ? 1 : 0;
    return score;
  }
}
