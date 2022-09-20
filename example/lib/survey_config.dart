import 'package:cognition_package/model.dart';
import 'package:research_package/model.dart';

/// Here the list of cognitive test are added to an RP ordered task.
/// Uncomment the ones you want to see a demo of.
RPOrderedTask surveyTask = RPOrderedTask(
  identifier: 'surveyTaskID',
  steps: [
    // reactionTimeStep,
    // pairedAssociatesLearningStep,
    tappingStep,
    corsiBlockTapping,
    // stroopEffect,
    // rapidVisualInfoProcessingStep,
    activityStepTrail,
    // continuousVisualTracking,
    // wordRecall,
    // pictureSequenceMemory,
    // activityStepLetterTapping,
    flanker,
    // visualArrayChange,
    // delayedRecall,
    completionStep,
  ],
);

RPCompletionStep completionStep =
    RPCompletionStep(identifier: 'completionID', title: 'Finished')
      ..title = 'Finished'
      ..text = 'Thank you for taking the tests';

RPActivityStep tappingStep = RPTappingActivity(
  'Tapping step ID',
);

RPActivityStep reactionTimeStep = RPReactionTimeActivity(
  'Reaction Time step ID',
);

RPActivityStep rapidVisualInfoProcessingStep =
    RPRapidVisualInfoProcessingActivity('RVIP step ID', lengthOfTest: 10);

RPActivityStep activityStepTrail = RPTrailMakingActivity('Trail Making step ID',
    trailType: TrailType.B, includeResults: false);

RPActivityStep activityStepLetterTapping =
    RPLetterTappingActivity('Letter Tapping step ID', includeResults: false);

RPActivityStep pairedAssociatesLearningStep =
    RPPairedAssociatesLearningActivity(
  'PAL step ID',
);

RPActivityStep corsiBlockTapping = RPCorsiBlockTappingActivity(
  'Corsi Block Tapping step ID',
);

RPActivityStep stroopEffect = RPStroopEffectActivity(
  'Stroop Effect step ID',
);

RPActivityStep flanker = RPFlankerActivity('Flanker step ID',
    lengthOfTest: 45 /* 300 */, numberOfCards: 10, includeResults: true);

RPActivityStep pictureSequenceMemory = RPPictureSequenceMemoryActivity(
    'PictureSequenceMemory step ID',
    lengthOfTest: 180,
    numberOfTests: 1,
    numberOfPics: 6,
    includeResults: false);

RPActivityStep wordRecall = RPWordRecallActivity('WordRecall step ID',
    lengthOfTest: 180, numberOfTests: 3, includeResults: false);

RPActivityStep delayedRecall = RPDelayedRecallActivity('DelayedRecall step ID',
    lengthOfTest: 180, numberOfTests: 3, includeResults: false);

RPActivityStep visualArrayChange = RPVisualArrayChangeActivity(
    'VisualArrayChange step ID',
    lengthOfTest: 180,
    numberOfTests: 3,
    waitTime: 3,
    includeResults: false);

RPActivityStep continuousVisualTracking = RPContinuousVisualTrackingActivity(
    'ContinuousVisualTracking step ID',
    numberOfTests: 3,
    amountOfDots: 15,
    dotSize: 40,
    lengthOfTest: 180,
    trackingSpeed: Duration(seconds: 5),
    includeResults: false);
