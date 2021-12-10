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

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cognition_package/model.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:reorderables/reorderables.dart';
import 'package:research_package/research_package.dart';

part 'src/ui/ActivityBody/RPUICorsiBlockTappingActivityBody.dart';
part 'src/ui/ActivityBody/RPUIFlankerActivityBody.dart';
part 'src/ui/ActivityBody/RPUILetterTappingActivityBody.dart';
part 'src/ui/ActivityBody/RPUIPairedAssociatesLearningActivityBody.dart';
part 'src/ui/ActivityBody/RPUIRapidVisualInfoProcessingActivityBody.dart';
part 'src/ui/ActivityBody/RPUIReactionTimeActivityBody.dart';
part 'src/ui/ActivityBody/RPUIStroopEffectActivityBody.dart';
part 'src/ui/ActivityBody/RPUITappingActivityBody.dart';
part 'src/ui/ActivityBody/RPUITrailMakingActivityBody.dart';
part 'src/ui/ActivityBody/RPUIPictureSequenceMemoryActivityBody.dart';
part 'src/ui/ActivityBody/RPUIWordRecallActivityBody.dart';
part 'src/ui/ActivityBody/RPUIDelayedRecallActivityBody.dart';
part 'src/ui/ActivityBody/RPUIVisualArrayChangeActivityBody.dart';
part 'src/ui/ActivityBody/RPUIContinuousVisualTrackingActivityBody.dart';
