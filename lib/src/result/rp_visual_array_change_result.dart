part of '../../../../model.dart';

/// Visual Array Change Test Result
@JsonSerializable(
    fieldRename: FieldRename.snake, includeIfNull: false, explicitToJson: true)
class RPVisualArrayChangeResult extends RPActivityResult {
  RPVisualArrayChangeResult({required super.identifier});

  /// Create a [RPVisualArrayChangeResult] from a set of results:
  ///
  ///  * [right]: the number of correct answers
  ///  * [wrong]: the number of wrong answers
  ///  * [times]: time taken to find the change
  ///  * [memoryTimes]: time taken to memorize the shapes
  ///  * [score]: score of the test calculated in model class
  factory RPVisualArrayChangeResult.fromResults(
    int wrong,
    int right,
    List<dynamic> times,
    List<dynamic> memoryTimes,
    int score,
  ) {
    var res = RPVisualArrayChangeResult(identifier: 'VisualArrayChangeResults');
    res.results.addAll({'Wrong guesses': wrong});
    res.results.addAll({'Right guesses': right});
    res.results.addAll({'Time taken to memorize': memoryTimes});
    res.results.addAll({'Time taken to guess': times});
    res.results.addAll({'score': score});
    return res;
  }

  factory RPVisualArrayChangeResult.fromJson(Map<String, dynamic> json) =>
      _$RPVisualArrayChangeResultFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RPVisualArrayChangeResultToJson(this);
}
