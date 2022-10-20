part of cognition_package_model;

/// Verbal Recognition Memory Test Result
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPWordRecallResult extends RPActivityResult {
  RPWordRecallResult({required String identifier})
      : super(identifier: identifier);

  /// make result for Word Recall Test
  /// wordList: list of words to be recalled
  /// resultlist1: list of recalled words in 1 repetition
  /// resultlist1: list of recalled words in 2 repetition
  /// timetaken: time taken to recall
  /// score: score of the test calculated in model class
  RPActivityResult makeResult(List<String> wordlist, List<String> resultlist1,
      List<String> resultlist2, List<dynamic> timesTaken, int score) {
    var res = RPActivityResult(identifier: identifier);
    res.results.addAll({'wordlist': wordlist});
    res.results.addAll({'resultlist1': resultlist1});
    res.results.addAll({'resultlist2': resultlist2});
    res.results.addAll({'times taken': timesTaken});
    res.results.addAll({'score': score});
    return res;
  }

  factory RPWordRecallResult.fromJson(Map<String, dynamic> json) =>
      _$RPWordRecallResultFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RPWordRecallResultToJson(this);
}
