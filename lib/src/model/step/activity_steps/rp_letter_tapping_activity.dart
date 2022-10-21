part of cognition_package_model;

/// Letter Tapping Test
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPLetterTappingActivity extends RPActivityStep {
  /// Create a Letter Tapping Test.
  RPLetterTappingActivity({
    required super.identifier,
    super.includeInstructions,
    super.includeResults,
  });
  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUILetterTappingActivityBody(this, eventLogger, onResultChange);

  @override
  int calculateScore(dynamic result) {
    int errors = result['errors'] as int;
    return errors < 2 ? 1 : 0;
  }

  @override
  Function get fromJsonFunction => _$RPLetterTappingActivityFromJson;
  factory RPLetterTappingActivity.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as RPLetterTappingActivity;
  @override
  Map<String, dynamic> toJson() => _$RPLetterTappingActivityToJson(this);
}
