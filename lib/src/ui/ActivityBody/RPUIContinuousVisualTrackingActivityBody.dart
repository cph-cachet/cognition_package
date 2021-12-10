part of cognition_package_ui;

class ContinuousVisualTracking extends StatefulWidget {
  final RPUIContinuousVisualTrackingActivityBody sWidget;
  final numberOfTests;
  final amountOfDots;
  final trackingSpeed;
  final dotSize;

  const ContinuousVisualTracking({
    Key? key,
    required this.sWidget,
    this.numberOfTests,
    this.amountOfDots,
    this.dotSize,
    this.trackingSpeed,
  }) : super(key: key);

  @override
  _ContinuousVisualTrackingState createState() =>
      _ContinuousVisualTrackingState(
          sWidget, numberOfTests, amountOfDots, dotSize, trackingSpeed);
}

class _ContinuousVisualTrackingState extends State<ContinuousVisualTracking> {
  final RPUIContinuousVisualTrackingActivityBody sWidget;
  final int numberOfTests;
  final int amountOfDots;
  final int dotSize;
  final Duration trackingSpeed;

  int wrong = 0;
  List<int> mistakes = [];
  List<int> rotation = [];
  bool waiting = false;
  bool guess = false;
  bool finished = false;
  List<bool> dots = [];
  var visualScoreList = [];
  int conCurrentNum = 1;

  /// fill list of dots with random values and add 2 to track the correct and wrong answers
  /// amount: amount of dots to add
  /// constraint: the constraint of the list
  /// avatarsize: the size of the dots
  List<AnimatedPositioned> getDots(int amount, constraints, avatarSize) {
    List<AnimatedPositioned> tDots = [];
    for (var i = 0; i < amount; i++) {
      tDots.add(new AnimatedPositioned(
        duration: trackingSpeed,
        left: avatarSize +
            (constraints.biggest.width - 2 * avatarSize) / 100.0 * rotation[i],
        top: avatarSize +
            (constraints.biggest.height - 2 * avatarSize) /
                100.0 *
                rotation[(i + amount) + 5],
        child: GestureDetector(
            onTap: () {
              if (guess) {
                setState(() {
                  wrong += 1;
                  mistakes[conCurrentNum] = mistakes[conCurrentNum] + 1;
                });
              }
            },
            child: new CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: Colors.grey,
            )),
      ));
    }
    for (var i = 0; i < 2; i++) {
      tDots.add(new AnimatedPositioned(
        duration: trackingSpeed,
        left: avatarSize +
            (constraints.biggest.width - 2 * avatarSize) /
                100.0 *
                rotation[i + amount],
        top: avatarSize +
            (constraints.biggest.height - 2 * avatarSize) /
                100.0 *
                rotation[i + amount + 5],
        child: GestureDetector(
            onTap: () {
              if (guess) {
                setState(() {
                  dots[i] = true;
                  if (listEquals(dots, [true, true])) {
                    makeGuess();
                  }
                });
              }
            },
            child: new CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: dots[i] ? Color(0xff1F669B) : Colors.grey,
            )),
      ));
    }
    return tDots;
  }

  _ContinuousVisualTrackingState(this.sWidget, this.numberOfTests,
      this.amountOfDots, this.dotSize, this.trackingSpeed);
  @override
  initState() {
    mistakes = List.filled(numberOfTests + 1, 0);
    mistakes[0] = -1;
    super.initState();
    rotation = getRotation();
    rotation.shuffle();
    dots = [true, true];
  }

  /// find new positions for all dots
  void shuffleCircles() {
    setState(() {
      rotation.shuffle();
    });
  }

  List<int> getRotation() => List.generate(100, (index) => rng.nextInt(100));

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
      rotation = getRotation();
      dots = [false, false];
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
  var rng = new Random();
  int seconds = 0;

  /// start the timer
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    testTimer = new Timer.periodic(
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

      var continuousVisualTrackingScore =
          sWidget.activity.calculateScore({'mistakes': mistakes});

      RPVisualTrackingResult visualTrackingResult =
          new RPVisualTrackingResult(identifier: 'visualTrackingTaskResult');
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
                  children: getDots(amountOfDots, constraints, dotSize));
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
                              Text("task $conCurrentNum/$numberOfTests")
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
                                  Text("Press the previously colored dots")))),
        )
      ])));
}

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
              padding: EdgeInsets.all(20),
              child: Text(
                'Find the blue dots on the screen.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Once ready, press "start" and the dots will turn grey and start moving.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Follow the dots and click on them once all the dots stop moving',
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
                body: ContinuousVisualTracking(
                    key: widget.key,
                    sWidget: widget,
                    numberOfTests: widget.activity.numberOfTests,
                    amountOfDots: widget.activity.amountOfDots,
                    dotSize: widget.activity.dotSize,
                    trackingSpeed: widget.activity.trackingSpeed)));
      case ActivityStatus.Result:
        return Center(
          child: Text(
            'results:  $score',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
      default:
        return Container();
    }
  }
}
