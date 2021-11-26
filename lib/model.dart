/// The domain model part of Research Package.
/// Contains the "building blocks" for creating surveys and obtaining informed consents.
/// Holds the different types of result classes.
/// Also responsible for the streams and BLoC classes to provide communication channels
/// between different parts of the package. ([BlocQuestion], [BlocTask])
/// For the UI representations of the classes visit the [research_package_ui] library.

library cognition_package_model;

// Imports
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

// Importing the UI library from Research Package
import 'package:cognition_package/ui.dart';

part 'src/model/step/activity_steps/RPCorsiBlockTappingActivity.dart';
part 'src/model/step/activity_steps/RPLetterTappingActivity.dart';
part 'src/model/step/activity_steps/RPPairedAssociatesLearningActivity.dart';
part 'src/model/step/activity_steps/RPRapidVisualInfoProcessingActivity.dart';
part 'src/model/step/activity_steps/RPReactionTimeActivity.dart';
part 'src/model/step/activity_steps/RPStroopEffectActivity.dart';
part 'src/model/step/activity_steps/RPTappingActivity.dart';
part 'src/model/step/activity_steps/RPTrailMakingActivity.dart';
part 'src/model/step/activity_steps/RPFlankerActivity.dart';
part 'src/model/step/activity_steps/RPPictureSequenceMemoryActivity.dart';
part 'src/model/step/activity_steps/RPVisualArrayChangeActivity.dart';
part 'src/model/step/activity_steps/RPContinuousVisualTrackingActivity.dart';

// JSON
part 'model.g.dart';
