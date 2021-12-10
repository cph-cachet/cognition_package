part of cognition_package_model;

/// A Flanker Test Result
@JsonSerializable()
class RPFlankerResult extends RPActivityResult {
  RPFlankerResult({required String identifier}) : super(identifier: identifier);

  /// make result for Flanker Test
  /// wrong: number of wrong answers
  /// right: number of right answers
  /// time: time taken to finish the test
  /// score: score of the test calculated in model class
  RPActivityResult makeResult(int wrong, int right, int time, int score) {
    var res = new RPActivityResult(identifier: identifier);
    res.results.addAll({"wrong swipes": wrong});
    res.results.addAll({"right swipes": right});
    res.results.addAll({"time": time});
    res.results.addAll({"score": score});
    return res;
  }
}
