part of cognition_package_model;

/// A Rapid Visual Information Proccesing Test
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPRapidVisualInfoProcessingActivity extends RPActivityStep {
  RPRapidVisualInfoProcessingActivity(
      {required super.identifier,
      super.includeInstructions,
      super.includeResults,
      this.interval = 9,
      this.lengthOfTest = 90,
      this.sequence = const [3, 6, 9]});

  /// Interval in which numbers to display are picked (could be 9 (0-9)).
  /// Default is 9.
  int interval;

  /// Test duration in seconds. Default is 90 seconds.
  int lengthOfTest;

  /// Sequence of numbers that is tracked. Default is 3,6,9.
  List<int> sequence;

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUIRapidVisualInfoProcessingActivityBody(
          this, eventLogger, onResultChange);

  @override
  Function get fromJsonFunction =>
      _$RPRapidVisualInfoProcessingActivityFromJson;
  factory RPRapidVisualInfoProcessingActivity.fromJson(
          Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as RPRapidVisualInfoProcessingActivity;
  @override
  Map<String, dynamic> toJson() =>
      _$RPRapidVisualInfoProcessingActivityToJson(this);
}
