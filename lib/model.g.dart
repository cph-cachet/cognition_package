// GENERATED CODE - DO NOT MODIFY BY HAND

part of cognition_package_model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RPCorsiBlockTappingActivity _$RPCorsiBlockTappingActivityFromJson(
    Map<String, dynamic> json) {
  return RPCorsiBlockTappingActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPCorsiBlockTappingActivityToJson(
        RPCorsiBlockTappingActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
    };

RPLetterTappingActivity _$RPLetterTappingActivityFromJson(
    Map<String, dynamic> json) {
  return RPLetterTappingActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPLetterTappingActivityToJson(
        RPLetterTappingActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
    };

RPPairedAssociatesLearningActivity _$RPPairedAssociatesLearningActivityFromJson(
    Map<String, dynamic> json) {
  return RPPairedAssociatesLearningActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    maxTestDuration: json['maxTestDuration'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPPairedAssociatesLearningActivityToJson(
        RPPairedAssociatesLearningActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'maxTestDuration': instance.maxTestDuration,
    };

RPRapidVisualInfoProcessingActivity
    _$RPRapidVisualInfoProcessingActivityFromJson(Map<String, dynamic> json) {
  return RPRapidVisualInfoProcessingActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    interval: json['interval'] as int,
    lengthOfTest: json['lengthOfTest'] as int,
    sequence: (json['sequence'] as List<dynamic>).map((e) => e as int).toList(),
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPRapidVisualInfoProcessingActivityToJson(
        RPRapidVisualInfoProcessingActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'interval': instance.interval,
      'lengthOfTest': instance.lengthOfTest,
      'sequence': instance.sequence,
    };

RPReactionTimeActivity _$RPReactionTimeActivityFromJson(
    Map<String, dynamic> json) {
  return RPReactionTimeActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
    switchInterval: json['switchInterval'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPReactionTimeActivityToJson(
        RPReactionTimeActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
      'switchInterval': instance.switchInterval,
    };

RPStroopEffectActivity _$RPStroopEffectActivityFromJson(
    Map<String, dynamic> json) {
  return RPStroopEffectActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
    displayTime: json['displayTime'] as int,
    delayTime: json['delayTime'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPStroopEffectActivityToJson(
        RPStroopEffectActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
      'displayTime': instance.displayTime,
      'delayTime': instance.delayTime,
    };

RPTappingActivity _$RPTappingActivityFromJson(Map<String, dynamic> json) {
  return RPTappingActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPTappingActivityToJson(RPTappingActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
    };

RPTrailMakingActivity _$RPTrailMakingActivityFromJson(
    Map<String, dynamic> json) {
  return RPTrailMakingActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    trailType: _$enumDecode(_$TrailTypeEnumMap, json['trailType']),
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPTrailMakingActivityToJson(
        RPTrailMakingActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'trailType': _$TrailTypeEnumMap[instance.trailType],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TrailTypeEnumMap = {
  TrailType.A: 'A',
  TrailType.B: 'B',
};

RPFlankerActivity _$RPFlankerActivityFromJson(Map<String, dynamic> json) {
  return RPFlankerActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
    numberOfCards: json['numberOfCards'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPFlankerActivityToJson(RPFlankerActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
      'numberOfCards': instance.numberOfCards,
    };

RPPictureSequenceMemoryActivity _$RPPictureSequenceMemoryActivityFromJson(
    Map<String, dynamic> json) {
  return RPPictureSequenceMemoryActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
    numberOfTests: json['numberOfTests'] as int,
    numberOfPics: json['numberOfPics'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPPictureSequenceMemoryActivityToJson(
        RPPictureSequenceMemoryActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
      'numberOfTests': instance.numberOfTests,
      'numberOfPics': instance.numberOfPics,
    };

RPWordRecallActivity _$RPWordRecallActivityFromJson(Map<String, dynamic> json) {
  return RPWordRecallActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
    numberOfTests: json['numberOfTests'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPWordRecallActivityToJson(
        RPWordRecallActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
      'numberOfTests': instance.numberOfTests,
    };

RPDelayedRecallActivity _$RPDelayedRecallActivityFromJson(
    Map<String, dynamic> json) {
  return RPDelayedRecallActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
    numberOfTests: json['numberOfTests'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPDelayedRecallActivityToJson(
        RPDelayedRecallActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
      'numberOfTests': instance.numberOfTests,
    };

RPVisualArrayChangeActivity _$RPVisualArrayChangeActivityFromJson(
    Map<String, dynamic> json) {
  return RPVisualArrayChangeActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
    waitTime: json['waitTime'] as int,
    numberOfTests: json['numberOfTests'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPVisualArrayChangeActivityToJson(
        RPVisualArrayChangeActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
      'numberOfTests': instance.numberOfTests,
      'waitTime': instance.waitTime,
    };

RPContinuousVisualTrackingActivity _$RPContinuousVisualTrackingActivityFromJson(
    Map<String, dynamic> json) {
  return RPContinuousVisualTrackingActivity(
    json['identifier'] as String,
    includeInstructions: json['includeInstructions'],
    includeResults: json['includeResults'],
    lengthOfTest: json['lengthOfTest'] as int,
    numberOfTests: json['numberOfTests'] as int,
    amountOfDots: json['amountOfDots'] as int,
    dotSize: json['dotSize'] as int,
    trackingSpeed: Duration(microseconds: json['trackingSpeed'] as int),
  )
    ..$type = json[r'$type'] as String?
    ..title = json['title'] as String
    ..text = json['text'] as String?
    ..optional = json['optional'] as bool;
}

Map<String, dynamic> _$RPContinuousVisualTrackingActivityToJson(
        RPContinuousVisualTrackingActivity instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'identifier': instance.identifier,
      'title': instance.title,
      'text': instance.text,
      'optional': instance.optional,
      'includeInstructions': instance.includeInstructions,
      'includeResults': instance.includeResults,
      'lengthOfTest': instance.lengthOfTest,
      'numberOfTests': instance.numberOfTests,
      'amountOfDots': instance.amountOfDots,
      'dotSize': instance.dotSize,
      'trackingSpeed': instance.trackingSpeed.inMicroseconds,
    };

RPVisualTrackingResult _$RPVisualTrackingResultFromJson(
    Map<String, dynamic> json) {
  return RPVisualTrackingResult(
    identifier: json['identifier'] as String,
  )
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String)
    ..endDate = json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String)
    ..results = json['results'] as Map<String, dynamic>
    ..stepTimes = StepTimes.fromJson(json['stepTimes'] as Map<String, dynamic>)
    ..interactions = (json['interactions'] as List<dynamic>)
        .map((e) => Interaction.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$RPVisualTrackingResultToJson(
        RPVisualTrackingResult instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'results': instance.results,
      'stepTimes': instance.stepTimes,
      'interactions': instance.interactions,
    };

RPFlankerResult _$RPFlankerResultFromJson(Map<String, dynamic> json) {
  return RPFlankerResult(
    identifier: json['identifier'] as String,
  )
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String)
    ..endDate = json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String)
    ..results = json['results'] as Map<String, dynamic>
    ..stepTimes = StepTimes.fromJson(json['stepTimes'] as Map<String, dynamic>)
    ..interactions = (json['interactions'] as List<dynamic>)
        .map((e) => Interaction.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$RPFlankerResultToJson(RPFlankerResult instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'results': instance.results,
      'stepTimes': instance.stepTimes,
      'interactions': instance.interactions,
    };

RPPictureSequenceResult _$RPPictureSequenceResultFromJson(
    Map<String, dynamic> json) {
  return RPPictureSequenceResult(
    identifier: json['identifier'] as String,
  )
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String)
    ..endDate = json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String)
    ..results = json['results'] as Map<String, dynamic>
    ..stepTimes = StepTimes.fromJson(json['stepTimes'] as Map<String, dynamic>)
    ..interactions = (json['interactions'] as List<dynamic>)
        .map((e) => Interaction.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$RPPictureSequenceResultToJson(
        RPPictureSequenceResult instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'results': instance.results,
      'stepTimes': instance.stepTimes,
      'interactions': instance.interactions,
    };

RPVisualArrayChangeResult _$RPVisualArrayChangeResultFromJson(
    Map<String, dynamic> json) {
  return RPVisualArrayChangeResult(
    identifier: json['identifier'] as String,
  )
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String)
    ..endDate = json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String)
    ..results = json['results'] as Map<String, dynamic>
    ..stepTimes = StepTimes.fromJson(json['stepTimes'] as Map<String, dynamic>)
    ..interactions = (json['interactions'] as List<dynamic>)
        .map((e) => Interaction.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$RPVisualArrayChangeResultToJson(
        RPVisualArrayChangeResult instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'results': instance.results,
      'stepTimes': instance.stepTimes,
      'interactions': instance.interactions,
    };

RPWordRecallResult _$RPWordRecallResultFromJson(Map<String, dynamic> json) {
  return RPWordRecallResult(
    identifier: json['identifier'] as String,
  )
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String)
    ..endDate = json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String)
    ..results = json['results'] as Map<String, dynamic>
    ..stepTimes = StepTimes.fromJson(json['stepTimes'] as Map<String, dynamic>)
    ..interactions = (json['interactions'] as List<dynamic>)
        .map((e) => Interaction.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$RPWordRecallResultToJson(RPWordRecallResult instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'results': instance.results,
      'stepTimes': instance.stepTimes,
      'interactions': instance.interactions,
    };

RPDelayedRecallResult _$RPDelayedRecallResultFromJson(
    Map<String, dynamic> json) {
  return RPDelayedRecallResult(
    identifier: json['identifier'] as String,
  )
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String)
    ..endDate = json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String)
    ..results = json['results'] as Map<String, dynamic>
    ..stepTimes = StepTimes.fromJson(json['stepTimes'] as Map<String, dynamic>)
    ..interactions = (json['interactions'] as List<dynamic>)
        .map((e) => Interaction.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$RPDelayedRecallResultToJson(
        RPDelayedRecallResult instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'results': instance.results,
      'stepTimes': instance.stepTimes,
      'interactions': instance.interactions,
    };
