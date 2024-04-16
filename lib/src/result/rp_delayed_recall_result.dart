part of '../../../../model.dart';

/// Delayed Recall Test Result
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPDelayedRecallResult extends RPActivityResult {
  RPDelayedRecallResult({required super.identifier});

  /// Create a [RPDelayedRecallResult] based on results for Delayed Recall Test:
  ///
  ///  * [wordList]: list of words to be recalled
  ///  * [resultList]: list of recalled words
  ///  * [timeTaken]: time taken to recall
  ///  * [score]: score of the test calculated in model class
  factory RPDelayedRecallResult.fromResults(
    List<String> wordList,
    List<String> resultList,
    int timeTaken,
    int score,
  ) {
    var res = RPDelayedRecallResult(identifier: 'DelayedRecallResult');
    res.results.addAll({'wordlist delayed': wordList});
    res.results.addAll({'resultlist3': resultList});
    res.results.addAll({'time taken': timeTaken});
    res.results.addAll({'score': score});
    return res;
  }

  factory RPDelayedRecallResult.fromJson(Map<String, dynamic> json) =>
      _$RPDelayedRecallResultFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RPDelayedRecallResultToJson(this);
}
