part of cognition_package_model;

/// Trail Making Test.
class RPTrailMakingActivity extends RPActivityStep {
  /// Contructor for creating a Trail Making Test.
  RPTrailMakingActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.trailType = TrailType.A})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// The type of trail used in the test.
  TrailType trailType;

  @override
  Widget stepBody(dynamic Function(dynamic) onResultChange,
      RPActivityEventLogger eventLogger) {
    return RPUITrailMakingActivityBody(this, eventLogger, onResultChange);
  }

  /// override the AcitivityResult with the results calculation of the test
  /// this is called when the test is finished
  /// [results] is number of mistakes made in the trailmaking task
  /// maximum score is 5 with -1 for each mistake made
  @override
  calculateScore(dynamic result) {
    var sum = 5 - result['mistakeCount'];
    return sum;
  }
}

/// The type of trails used in a Trail Making test.
enum TrailType {
  /// Numbers only.
  A,

  /// Numbers and letters alternating.
  B,
}
