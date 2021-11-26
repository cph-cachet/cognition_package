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
          sWidget, numberOfTest, amountOfDots, dotSize, trackingSpeed);
}

class _ContinuousVisualTrackingState extends State<ContinuousVisualTracking> {
  final RPUIContinuousVisualTrackingActivityBody sWidget;
  final int numberOfTests;
  final int amountOfDots;
  final int dotSize;
  final Duration trackingSpeed;
  // Dynamically load cards from database

  List<int> rotation = [];
  bool waiting = false;
  bool guess = false;
  bool finished = false;
  List<bool> dots = [];
  int wrong = 0;
  int conCurrentNum = 1;

  // int connumberOfTest = 3;
  // int amount = 10;
  // Duration trackingSpeed1 = Duration(seconds: 10);

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
              setState(() {
                wrong += 1;
              });
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
              setState(() {
                dots[i] = true;
                if (listEquals(dots, [true, true])) {
                  makeGuess();
                }
              });
            },
            child: new CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: dots[i] ? Colors.green : Colors.grey,
            )),
      ));
    }
    return tDots;
  }

  _ContinuousVisualTrackingState(this.sWidget, this.numberOfTests,
      this.amountOfDots, this.dotSize, this.trackingSpeed);
  Timer? _timer;
  @override
  initState() {
    print("numberOfTests: $numberOfTests");
    print("amountOfDots: $amountOfDots");
    print("dotSize: $dotSize");
    print("trackingSpeed: $trackingSpeed");
    super.initState();
    _timer = Timer.periodic(trackingSpeed, (Timer t) => shuffleCircles());
    rotation = getRotation();
    rotation.shuffle();
    dots = [true, true];
    Timer(Duration(milliseconds: 10), startTest);
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void shuffleCircles() {
    setState(() {
      rotation.shuffle();
    });
  }

  List<int> getRotation() => List.generate(100, (index) => rng.nextInt(100));

  void resetTest() async {
    setState(() {
      dots = [true, true];
      waiting = false;
      guess = false;
      rotation = getRotation();
      _timer = Timer.periodic(trackingSpeed, (Timer t) => shuffleCircles());
      Timer(trackingSpeed, startTest);
    });
  }

  void startTest() async {
    setState(() {
      _timer!.cancel();
      rotation = getRotation();
    });
    //sleep(Duration(seconds: 2));
    await Future.delayed(trackingSpeed);
    setState(() {
      waiting = false;
      guess = true;
      dots = [false, false];
    });
  }

  var rng = new Random();

  void makeGuess() {
    print(conCurrentNum);
    print(numberOfTests);
    if (conCurrentNum == numberOfTests) {
      sWidget.eventLogger.testEnded();
      sWidget.onResultChange({"wrong taps: ": wrong});
      if (sWidget.activity.includeResults) {
        _timer!.cancel();
        sWidget.eventLogger.resultsShown();
        setState(() {
          finished = true;
        });
      }
    } else {
      _timer!.cancel();
      conCurrentNum += 1;
      resetTest();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height - 235,
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
                              child: Text("task $conCurrentNum/$numberOfTests"))
                      : finished
                          ? Center(
                              child: Container(
                              child: Text(
                                'Correct',
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

class _RPUI_ContinuousVisualTrackingActivityBodyState
    extends State<RPUIContinuousVisualTrackingActivityBody> {
  late ActivityStatus activityStatus;
  int corsiSpan = 0;
  late int highlightedBlockID;
  late List<int> blocks;
  List<int> tapOrder = [];
  bool readyForTap = false;
  bool finishedTask = false;
  bool failedLast = false;
  String taskInfo = '';
  int numberOfBlocks = 2;

  @override
  initState() {
    super.initState();
    blocks = List.generate(9, (index) => index);
    if (widget.activity.includeInstructions) {
      activityStatus = ActivityStatus.Instruction;
      widget.eventLogger.instructionStarted();
    } else {
      activityStatus = ActivityStatus.Test;
      widget.eventLogger.testStarted();
      startTest();
    }
  }

  void startTest() async {
    setState(() {
      taskInfo = 'Wait';
      readyForTap = false;
      tapOrder.clear();
      blocks.shuffle();
    });
    await Future.delayed(Duration(seconds: 1));
    for (int i = 0; i < numberOfBlocks; i++) {
      if (activityStatus == ActivityStatus.Test && this.mounted) {
        setState(() {
          highlightedBlockID = blocks[i];
        });
      }
      await Future.delayed(Duration(milliseconds: 1000));
    }
    if (activityStatus == ActivityStatus.Test && this.mounted) {
      setState(() {
        readyForTap = true;
        taskInfo = 'Go';
      });
    }
    // rpcontinuiusvisualresult
    Timer(Duration(seconds: widget.activity.lengthOfTest), () {
      //when time is up, change window and set result
      if (this.mounted) {
        widget.eventLogger.testEnded();
        widget.onResultChange({"Correct swipes": score});
        if (widget.activity.includeResults) {
          widget.eventLogger.resultsShown();
          setState(() {
            activityStatus = ActivityStatus.Result;
          });
        }
      }
    });
  }

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
                'Follow the green dots around the screen, once they stop and turn grey point them out',
                style: TextStyle(fontSize: 20),
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
                            'packages/research_package/assets/images/Corsiintro.png'))),
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
                  startTest();
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
            'results:  ${score}',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
      default:
        return Container();
    }
  }
}
