// GENERATED CODE - DO NOT MODIFY BY HAND
// auto generate json code (.g files) with:
//   flutter pub run build_runner build --delete-conflicting-outputs

part of cognition_package_model;

bool _fromJsonFunctionsRegistrered = false;

/// Register all the fromJson functions for the deployment domain classes.
void _registerFromJsonFunctions() {
  if (_fromJsonFunctionsRegistrered) return;
  _fromJsonFunctionsRegistrered = true;

  // activity step classes
  FromJsonFactory()
      .register(RPContinuousVisualTrackingActivity(identifier: ''));
  FromJsonFactory().register(RPCorsiBlockTappingActivity(identifier: ''));
  FromJsonFactory().register(RPDelayedRecallActivity(identifier: ''));
  FromJsonFactory().register(RPFlankerActivity(identifier: ''));
  FromJsonFactory().register(RPLetterTappingActivity(identifier: ''));
  FromJsonFactory()
      .register(RPPairedAssociatesLearningActivity(identifier: ''));
  FromJsonFactory().register(RPPictureSequenceMemoryActivity(identifier: ''));
  FromJsonFactory()
      .register(RPRapidVisualInfoProcessingActivity(identifier: ''));
  FromJsonFactory().register(RPReactionTimeActivity(identifier: ''));
  FromJsonFactory().register(RPStroopEffectActivity(identifier: ''));
  FromJsonFactory().register(RPTappingActivity(identifier: ''));
  FromJsonFactory().register(RPTrailMakingActivity(identifier: ''));
  FromJsonFactory().register(RPVisualArrayChangeActivity(identifier: ''));
  FromJsonFactory().register(RPWordRecallActivity(identifier: ''));
}
