part of cognition_package_ui;

/// The [RPUIContinuousVisualTrackingActivityBody] class defines the UI for the
/// instructions and test phase of the continuous visual tracking task.
class RPUIContinuousVisualTrackingActivityBody extends StatefulWidget {
  final RPContinuousVisualTrackingActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityEventLogger eventLogger;

  RPUIContinuousVisualTrackingActivityBody(
      this.activity, this.eventLogger, this.onResultChange);

  @override
  _RPUI_ContinuousVisualTrackingActivityBodyState createState() =>
      _RPUI_ContinuousVisualTrackingActivityBodyState();
}

/// score counter for the continuous visual tracking task used in [RPUIContinuousVisualTrackingActivityBody]
int continuousVisualTrackingScore = 0;

// ignore: camel_case_types
class _RPUI_ContinuousVisualTrackingActivityBodyState
    extends State<RPUIContinuousVisualTrackingActivityBody> {
  late ActivityStatus activityStatus;

  @override
  initState() {
    super.initState();
    if (widget.activity.includeInstructions) {
      activityStatus = ActivityStatus.Instruction;
      widget.eventLogger.instructionStarted();
    } else {
      activityStatus = ActivityStatus.Test;
      widget.eventLogger.testStarted();
    }
  }

  /// build the activity with instructions, test and results
  @override
  Widget build(BuildContext context) {
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Find the blue dots on the next screen. These are the targets dots.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Once ready, press "start" and the target dots will turn grey and start moving.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Follow the target dots around the screen',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Once the dots stop moving find and click on the target dots and they will turn the original color.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'packages/cognition_package/assets/images/visual_tracking.png'))),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              // ignore: deprecated_member_use
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                onPressed: () {
                  widget.eventLogger.instructionEnded();
                  widget.eventLogger.testStarted();
                  setState(() {
                    activityStatus = ActivityStatus.Test;
                  });
                },
                child: Text(
                  'Ready',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      case ActivityStatus.Test:
        return Center(
            child: Scaffold(
                body: _ContinuousVisualTrackingActivityBody(
                    key: widget.key,
                    topLevelWidget: widget,
                    numberOfTests: widget.activity.numberOfTests,
                    amountOfDots: widget.activity.amountOfDots,
                    amountOfTargets: widget.activity.amountOfTargets,
                    dotSize: widget.activity.dotSize,
                    trackingSpeed: widget.activity.trackingSpeed)));
      case ActivityStatus.Result:
        return Center(
          child: Text(
            'results:  $continuousVisualTrackingScore',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
      default:
        return Container();
    }
  }
}

/// The [_ContinuousVisualTrackingActivityBody] class defines the UI for the
/// continuous visual tracking task.
class _ContinuousVisualTrackingActivityBody extends StatefulWidget {
  /// property to pass on the top level widget
  final RPUIContinuousVisualTrackingActivityBody topLevelWidget;

  /// the number of tests to run
  final int numberOfTests;

  /// the number of dots to display
  final int amountOfDots;

  final int amountOfTargets;

  /// the speed of the dots in milliseconds
  final Duration trackingSpeed;

  /// the size of the dots to display
  final int dotSize;

  /// the [continuousVisualTrackingActivityBody] constructor
  const _ContinuousVisualTrackingActivityBody({
    Key? key,
    required this.topLevelWidget,
    required this.numberOfTests,
    required this.amountOfDots,
    required this.amountOfTargets,
    required this.dotSize,
    required this.trackingSpeed,
  }) : super(key: key);

  @override
  _ContinuousVisualTrackingActivityBodyState createState() =>
      _ContinuousVisualTrackingActivityBodyState(topLevelWidget, numberOfTests,
          amountOfDots, amountOfTargets, dotSize, trackingSpeed);
}

/// state class for [_ContinuousVisualTrackingActivityBody]
class _ContinuousVisualTrackingActivityBodyState
    extends State<_ContinuousVisualTrackingActivityBody> {
  final RPUIContinuousVisualTrackingActivityBody sWidget;
  final int numberOfTests;
  final int amountOfDots;
  final int amountOfTargets;
  final int dotSize;
  final Duration trackingSpeed;

  int wrong = 0;
  List<int> mistakes = [];
  List<int> positions = [];
  bool waiting = false;
  bool guess = false;
  bool finished = false;
  List<bool> dots = [];
  List<bool> distractors = [];
  var visualScoreList = [];
  int conCurrentNum = 1;

  /// fill list of dots with random values and add 2 to track the correct and wrong answers
  /// amount: amount of dots to add
  /// constraint: the constraint of the list
  /// avatarsize: the size of the dots
  List<AnimatedPositioned> getDots(
      int amount, int targetAmount, constraints, avatarSize) {
    List<AnimatedPositioned> tDots = [];
    for (var i = 0; i < amount; i++) {
      tDots.add(AnimatedPositioned(
        duration: trackingSpeed,
        left: avatarSize +
            (constraints.biggest.width - 2 * avatarSize) / 100.0 * positions[i],
        top: avatarSize +
            (constraints.biggest.height - 2 * avatarSize) /
                100.0 *
                positions[(i + amount) + 5],
        child: GestureDetector(
            onTap: () async {
              if (guess) {
                setState(() {
                  distractors[i] = true;
                  wrong += 1;
                  mistakes[conCurrentNum] = mistakes[conCurrentNum] + 1;
                });
                await Future.delayed(Duration(milliseconds: 250));
                setState(() {
                  distractors[i] = false;
                });
              }
            },
            child: CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: distractors[i] ? Color(0xffFF0000) : Colors.grey,
            )),
      ));
    }
    for (var i = 0; i < targetAmount; i++) {
      tDots.add(AnimatedPositioned(
        duration: trackingSpeed,
        left: avatarSize +
            (constraints.biggest.width - 2 * avatarSize) /
                100.0 *
                positions[i + amount],
        top: avatarSize +
            (constraints.biggest.height - 2 * avatarSize) /
                100.0 *
                positions[i + amount + 5],
        child: GestureDetector(
            onTap: () {
              if (guess) {
                setState(() {
                  dots[i] = true;
                  var targetsFound = dots.where((item) => item == true).length;
                  if (targetsFound == targetAmount) {
                    makeGuess();
                  }
                });
              }
            },
            child: CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: dots[i] ? Color(0xff1F669B) : Colors.grey,
            )),
      ));
    }
    return tDots;
  }

  _ContinuousVisualTrackingActivityBodyState(
      this.sWidget,
      this.numberOfTests,
      this.amountOfDots,
      this.amountOfTargets,
      this.dotSize,
      this.trackingSpeed);
  @override
  initState() {
    mistakes = List.filled(numberOfTests + 1, 0);
    mistakes[0] = -1;
    super.initState();
    positions = generatePositions();
    positions.shuffle();
    dots = List.filled(amountOfTargets, true);
    distractors = List.filled(amountOfDots, false);
  }

  /// find new positions for all dots
  void shuffleDots() {
    setState(() {
      positions.shuffle();
    });
  }

  /// generate new positions for all dots
  List<int> generatePositions() =>
      List.generate(100, (index) => rng.nextInt(100));

  /// reset the test
  void resetTest() async {
    setState(() {
      waiting = false;
      guess = false;
    });
  }

  /// start the test
  void startTest() async {
    setState(() {
      positions = generatePositions();
      dots = List.filled(amountOfTargets, false);
    });
    await Future.delayed(trackingSpeed);
    setState(() {
      waiting = false;
      guess = true;
    });
    startTimer();
  }

  /// Timer for the test
  late Timer testTimer;
  var rng = Random();
  int seconds = 0;

  /// start the timer
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    testTimer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (seconds < 0) {
            timer.cancel();
          } else {
            seconds = seconds + 1;
          }
        },
      ),
    );
  }

  /// make a guess and check if its correct
  void makeGuess() {
    if (conCurrentNum == numberOfTests) {
      sWidget.eventLogger.testEnded();
      visualScoreList.add(seconds);
      testTimer.cancel();
      seconds = 0;

      continuousVisualTrackingScore =
          sWidget.activity.calculateScore({'mistakes': mistakes});

      RPVisualTrackingResult visualTrackingResult =
          RPVisualTrackingResult(identifier: 'visualTrackingTaskResult');
      var taskResults = visualTrackingResult.makeResult(
          mistakes, visualScoreList, continuousVisualTrackingScore);
      sWidget.onResultChange(taskResults.results);
      if (sWidget.activity.includeResults) {
        sWidget.eventLogger.resultsShown();
        setState(() {
          finished = true;
        });
      }
    } else {
      visualScoreList.add(seconds);
      testTimer.cancel();
      seconds = 0;
      conCurrentNum += 1;
      resetTest();
    }
  }

  /// Build the main test phase
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height - 270,
            width: MediaQuery.of(context).size.width - 20,
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                  children: getDots(
                      amountOfDots, amountOfTargets, constraints, dotSize));
            })),
        Container(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: !guess
                      ? waiting
                          ? Container()
                          : Center(
                              child: Column(children: [
                              // ignore: deprecated_member_use
                              OutlineButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                onPressed: () {
                                  startTest();
                                },
                                child: Text(
                                  'Start',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Text('task $conCurrentNum/$numberOfTests')
                            ]))
                      : finished
                          ? Center(
                              child: Container(
                              child: Text(
                                'Click next to continue',
                                style: TextStyle(fontSize: 18),
                              ),
                            ))
                          : Center(
                              child:
                                  Text('Press the previously colored dots')))),
        )
      ])));
}
