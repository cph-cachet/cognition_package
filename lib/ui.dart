/// The UI library of Research Package.
///
/// Normally you don't need to use these widgets directly. After creating the model objects from [research_package_model]
/// and adding them to an [RPTask] you can present the different elements by passing it to an [RPUITask].
///
/// This library contains various UI representations (Widgets) of the objects declared in [research_package_model].
/// Many of these Widgets are responsible for making the collected results accessible to others.
/// Also contains general styles, UI statics used in Research Package UI in [RPStyles].

library cognition_package_ui;

// Imports
import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:cognition_package/model.dart';
import 'package:reorderables/reorderables.dart';
import 'package:research_package/research_package.dart';

part 'src/ui/ActivityBody/rpui_corsi_block_tapping_activity_body.dart';
part 'src/ui/ActivityBody/rpui_flanker_activity_body.dart';
part 'src/ui/ActivityBody/rpui_letter_tapping_activity_body.dart';
part 'src/ui/ActivityBody/rpui_paired_associates_learning_activity_body.dart';
part 'src/ui/ActivityBody/rpui_rapid_visual_info_processing_activity_body.dart';
part 'src/ui/ActivityBody/rpui_reaction_time_activity_body.dart';
part 'src/ui/ActivityBody/rpui_stroop_effect_activity_body.dart';
part 'src/ui/ActivityBody/rpui_tapping_activity_body.dart';
part 'src/ui/ActivityBody/rpui_trail_making_activity_body.dart';
part 'src/ui/ActivityBody/rpui_picture_sequence_memory_activity_body.dart';
part 'src/ui/ActivityBody/rpui_word_recall_activity_body.dart';
part 'src/ui/ActivityBody/rpui_delayed_recall_activity_body.dart';
part 'src/ui/ActivityBody/rpui_visual_array_change_activity_body.dart';
part 'src/ui/ActivityBody/rpui_continuous_visual_tracking_activity_body.dart';
