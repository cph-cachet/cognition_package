/// The domain model part of Research Package.
/// Contains the "building blocks" for creating surveys and obtaining informed consents.
/// Holds the different types of result classes.
/// Also responsible for the streams and BLoC classes to provide communication channels
/// between different parts of the package. ([BlocQuestion], [BlocTask])
/// For the UI representations of the classes visit the [research_package_ui] library.

library cognition_package_model;

import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';

// Importing the UI library from Research Package
import 'package:cognition_package/ui.dart';

part 'src/model/step/activity_steps/rp_corsi_block_tapping_activity.dart';
part 'src/model/step/activity_steps/rp_letter_tapping_activity.dart';
part 'src/model/step/activity_steps/rp_paired_associative_learning_activity.dart';
part 'src/model/step/activity_steps/rp_rapid_visual_info_processing_activity.dart';
part 'src/model/step/activity_steps/rp_reaction_time_activity.dart';
part 'src/model/step/activity_steps/rp_stroop_effect_activity.dart';
part 'src/model/step/activity_steps/rp_tapping_activity.dart';
part 'src/model/step/activity_steps/rp_trail_making_activity.dart';
part 'src/model/step/activity_steps/rp_flanker_activity.dart';
part 'src/model/step/activity_steps/rp_picture_sequence_memory_activity.dart';
part 'src/model/step/activity_steps/rp_word_recall_activity.dart';
part 'src/model/step/activity_steps/rp_delayed_recall_activity.dart';
part 'src/model/step/activity_steps/rp_visual_array_change_activity.dart';
part 'src/model/step/activity_steps/rp_continuous_visual_tracking_activity.dart';

part 'src/result/rp_visual_tracking_result.dart';
part 'src/result/rp_flanker_result.dart';
part 'src/result/rp_picture_sequence_memory_result.dart';
part 'src/result/rp_visual_array_change_result.dart';
part 'src/result/rp_word_recall_result.dart';
part 'src/result/rp_delayed_recall_result.dart';

// JSON
part 'model.g.dart';
