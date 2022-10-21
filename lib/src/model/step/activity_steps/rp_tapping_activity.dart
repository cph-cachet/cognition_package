part of cognition_package_model;

/// Tapping Test.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPTappingActivity extends RPActivityStep {
  /// Contructor for creating a Tapping Test.
  RPTappingActivity(
      {required super.identifier,
      super.includeInstructions,
      super.includeResults,
      this.lengthOfTest = 30});

  /// Test length in seconds. Default is 30 seconds.
  int lengthOfTest;

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUITappingActivityBody(this, eventLogger, onResultChange);

  @override
  Function get fromJsonFunction => _$RPTappingActivityFromJson;
  factory RPTappingActivity.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as RPTappingActivity;
  @override
  Map<String, dynamic> toJson() => _$RPTappingActivityToJson(this);
}
