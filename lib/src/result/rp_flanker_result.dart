part of cognition_package_model;

/// Flanker Test Result
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPFlankerResult extends RPActivityResult {
  /// Create an empty Flanker Test result.
  RPFlankerResult({required super.identifier});

  /// Create a Flanker Test result based on obtained results.
  ///
  /// * [wrong]: number of wrong answers
  /// * [right]: number of right answers
  /// * [time]: time taken to finish the test
  /// * [score]: score of the test calculated in model class
  factory RPFlankerResult.fromResults(
    int wrong,
    int right,
    int time,
    int score,
    double meanCongruent,
    double meanIncongruent,
    int numberCardsCongruent,
    int numberCardsIncongruent,
  ) {
    var res = RPFlankerResult(identifier: 'FlankerTaskResult');
    res.results.addAll({'wrong swipes': wrong});
    res.results.addAll({'right swipes': right});
    res.results.addAll({'time': time});
    res.results.addAll({'score': score});
    res.results.addAll({'meanCongruent': meanCongruent});
    res.results.addAll({'meanIncongruent': meanIncongruent});
    res.results.addAll({'numberCardsCongruent': numberCardsCongruent});
    res.results.addAll({'numberCardsIncongruent': numberCardsIncongruent});
    return res;
  }

  factory RPFlankerResult.fromJson(Map<String, dynamic> json) =>
      _$RPFlankerResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RPFlankerResultToJson(this);
}
