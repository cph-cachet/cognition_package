part of cognition_package_model;

/// Multiple Object Tracking Test Result
class RPVisualTrackingResult extends RPActivityResult {
  RPVisualTrackingResult({required String identifier})
      : super(identifier: identifier);

  /// make result for Multiple Object Tracking test
  /// mistakes: number of mistakes made in each repetition
  /// times: time taken to finish the test
  /// score: score of the test calculated in model class
  RPActivityResult makeResult(
      List<dynamic> mistakes, List<dynamic> times, int score) {
    var res = RPActivityResult(identifier: identifier);
    res.results.addAll({'mistakes': mistakes});
    res.results.addAll({'times': times});
    res.results.addAll({'score': score});
    return res;
  }
}
