part of cognition_package_model;

/// Corsi Block Tapping Test.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPCorsiBlockTappingActivity extends RPActivityStep {
  /// Create Corsi Block Tapping Test.
  RPCorsiBlockTappingActivity({
    required super.identifier,
    super.includeInstructions,
    super.includeResults,
  });

  @override
  Widget stepBody(
    dynamic Function(dynamic) onResultChange,
    RPActivityEventLogger eventLogger,
  ) =>
      RPUICorsiBlockTappingActivityBody(this, eventLogger, onResultChange);

  @override
  Function get fromJsonFunction => _$RPCorsiBlockTappingActivityFromJson;
  factory RPCorsiBlockTappingActivity.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as RPCorsiBlockTappingActivity;
  @override
  Map<String, dynamic> toJson() => _$RPCorsiBlockTappingActivityToJson(this);
}
