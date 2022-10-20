part of cognition_package_model;

/// Flanker Test.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPFlankerActivity extends RPActivityStep {
  RPFlankerActivity({
    required super.identifier,
    super.includeInstructions,
    super.includeResults,
    this.lengthOfTest = 90,
    this.numberOfCards = 25,
  });

  /// Test duration in seconds. Default is 90 seconds.
  int lengthOfTest;

  /// Number of cards to be presented. Default is 25.
  int numberOfCards;

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUIFlankerActivityBody(this, eventLogger, onResultChange);

  /// The result is the number of mistakes made during the test.
  /// If the number of mistakes > 2, the test is failed and a score of 0 is
  /// returned. Othervise, a score of 1 is returned.
  @override
  int calculateScore(dynamic result) {
    var accuracy = result['correct'] / (result['correct'] + result['mistakes']);

    var conSum = result['congruentTimes'].fold(0, (p, c) => p + c);
    var meanCongruent = conSum / result['congruentTimes'].length;

    var inconSum = result['incongruentTimes'].fold(0, (p, c) => p + c);
    var meanIncongruent = inconSum / result['incongruentTimes'].length;

    int sum = 0;
    try {
      if ((meanIncongruent - meanCongruent) as double < 500) sum = 1;
      if (accuracy as double < 0.73) sum = 0;
    } catch (error) {
      print('$runtimeType - $error');
    }

    return sum;
  }

  @override
  Function get fromJsonFunction => _$RPFlankerActivityFromJson;
  factory RPFlankerActivity.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as RPFlankerActivity;
  @override
  Map<String, dynamic> toJson() => _$RPFlankerActivityToJson(this);
}
