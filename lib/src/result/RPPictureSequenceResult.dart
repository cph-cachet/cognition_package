part of cognition_package_model;

/// A Picture Sequence Memory Test Result
@JsonSerializable()
class RPPictureSequenceResult extends RPActivityResult {
  RPPictureSequenceResult({required String identifier})
      : super(identifier: identifier);

  /// make result for Picture Sequence Memory Test
  /// moves: list of the number of moves made to complete the test
  /// times: time taken for each repetition
  /// memoryTime: time taken to memorize the sequence of images
  /// score: score of the test calculated in model class
  RPActivityResult makeResult(List<dynamic> moves, List<dynamic> scores,
      List<dynamic> times, List<dynamic> memoryTimes, int score) {
    var res = new RPActivityResult(identifier: identifier);
    res.results.addAll({'Amount of moves': moves});
    res.results.addAll({'Amount of correct pairs': scores});
    res.results.addAll({'Time taken to memorize': memoryTimes});
    res.results.addAll({'Time taken to move pictures': times});
    res.results.addAll({'score': score});
    return res;
  }
}
