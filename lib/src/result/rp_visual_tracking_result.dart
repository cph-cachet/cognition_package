part of '../../../../model.dart';

/// Multiple Object Tracking Test Result
@JsonSerializable(
    fieldRename: FieldRename.snake, includeIfNull: false, explicitToJson: true)
class RPVisualTrackingResult extends RPActivityResult {
  RPVisualTrackingResult({required super.identifier});

  /// Create a [RPVisualTrackingResult] from result for Multiple Object Tracking test:
  ///
  ///  * [mistakes]: number of mistakes made in each repetition
  ///  * [times]: time taken to finish the test
  ///  * [score]: score of the test calculated in model class
  factory RPVisualTrackingResult.fromResults(
    List<dynamic> mistakes,
    List<dynamic> times,
    int score,
  ) {
    var res = RPVisualTrackingResult(identifier: 'VisualTrackingTaskResult');
    res.results.addAll({'mistakes': mistakes});
    res.results.addAll({'times': times});
    res.results.addAll({'score': score});
    return res;
  }

  factory RPVisualTrackingResult.fromJson(Map<String, dynamic> json) =>
      _$RPVisualTrackingResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RPVisualTrackingResultToJson(this);
}
