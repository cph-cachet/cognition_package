part of cognition_package_ui;

class VisualArrayChange extends StatefulWidget {
  final RPUIVisualArrayChangeActivityBody sWidget;
  final numberOfTests;
  final waitTime;

  const VisualArrayChange(
      {Key? key, required this.sWidget, this.numberOfTests, this.waitTime})
      : super(key: key);

  @override
  _VisualArrayChangeState createState() =>
      _VisualArrayChangeState(sWidget, numberOfTests, waitTime);
}

class _VisualArrayChangeState extends State<VisualArrayChange> {
  final RPUIVisualArrayChangeActivityBody sWidget;
  final int numberOfTests;
  final int waitTime;
  List<Shape> original = [];
  List<Shape> pictures = [];
  List<Shape> top = [];
  List<Shape> arrow = [];
  List<Shape> hourglass = [];
  List<EdgeInsets> padding = [];
  List<int> rotation = [];
  List<int> color = [];
  bool waiting = false;
  bool guess = false;
  bool finished = false;
  int time = 0;
  bool changed = false;
  int visualScore = 0;
  int viscurrentNum = 1;

  int right = 0;
  int wrong = 0;
  var memoryTimes = [];
  var times = [];

  List<String> arrows = [
    'packages/cognition_package/assets/images/arrow_1.png',
    'packages/cognition_package/assets/images/arrow_2.png',
    'packages/cognition_package/assets/images/arrow_3.png',
    'packages/cognition_package/assets/images/arrow_4.png',
    'packages/cognition_package/assets/images/arrow_5.png',
  ];

  List<String> tops = [
    'packages/cognition_package/assets/images/boomerang_1.png',
    'packages/cognition_package/assets/images/boomerang_2.png',
    'packages/cognition_package/assets/images/boomerang_3.png',
    'packages/cognition_package/assets/images/boomerang_4.png',
    'packages/cognition_package/assets/images/boomerang_5.png',
  ];

  List<String> hourglasses = [
    'packages/cognition_package/assets/images/hourglass_1.png',
    'packages/cognition_package/assets/images/hourglass_2.png',
    'packages/cognition_package/assets/images/hourglass_3.png',
    'packages/cognition_package/assets/images/hourglass_4.png',
    'packages/cognition_package/assets/images/hourglass_5.png',
  ];

  _VisualArrayChangeState(this.sWidget, this.numberOfTests, this.waitTime);
  List<Shape> getPictures(List<String> list) => List.generate(
        3,
        (index) => Shape(
          name: index.toString(),
          urlImage: list[index],
          index: index,
        ),
      );

  @override
  initState() {
    super.initState();
    top = getPictures(tops);
    hourglass = getPictures(hourglasses);
    arrow = getPictures(arrows);
    padding = getPadding();
    rotation = getRotation();
    color = getColor();
    pictures.shuffle();
    for (Shape picl in pictures) {
      original.add(picl);
    }
    memorySeconds = 0;
    startMemoryTimer();
  }

  List<int> getRotation() => List.generate(6, (index) => rng.nextInt(100));
  List<int> getColor() => List.generate(3, (index) => rng.nextInt(3));

  List<EdgeInsets> getPadding() => List.generate(
      4,
      (index) => EdgeInsets.fromLTRB(
          rng.nextInt(300).toDouble(),
          rng.nextInt(100).toDouble(),
          rng.nextInt(300).toDouble(),
          rng.nextInt(100).toDouble()));

  void resetTest() async {
    setState(() {
      changed = false;
      waiting = false;
      guess = false;
      pictures.shuffle();
      padding = getPadding();
      rotation = getRotation();
      color = getColor();
      original = [];
      for (Shape picl in pictures) {
        original.add(picl);
      }
    });
    memorySeconds = 0;
    startMemoryTimer();
  }

  void startTest() async {
    memoryTimer.cancel();
    memoryTimes.add(memorySeconds);
    memorySeconds = 0;

    if (rng.nextBool()) {
      List<int> og = color;
      color = getColor();
      if (color != og) {
        changed = true;
      }
    }

    setState(() {
      viscurrentNum += 1;
      waiting = true;
      pictures.shuffle();
      padding.shuffle();
      rotation = getRotation();
    });
    await Future.delayed(Duration(seconds: waitTime));
    setState(() {
      waiting = false;
      guess = true;
    });
    startTimer();
  }

  var rng = new Random();

  late Timer _timer;
  int seconds = 0;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
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

  late Timer memoryTimer;
  int memorySeconds = 0;
  void startMemoryTimer() {
    const oneSec = const Duration(seconds: 1);
    memoryTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (seconds < 0) {
            timer.cancel();
          } else {
            memorySeconds = memorySeconds + 1;
          }
        },
      ),
    );
  }

  void same() {
    _timer.cancel();
    times.add(seconds);
    seconds = 0;

    if (!changed) {
      if (viscurrentNum > numberOfTests) {
        visualScore += 1;
        right += 1;
        sWidget.eventLogger.testEnded();

        var visualArrayChangeScore =
            sWidget.activity.calculateScore({'correct': right});
        RPVisualArrayChangeResult flankerResult = new RPVisualArrayChangeResult(
            identifier: 'visualArrayChangeResults');
        var taskResults = flankerResult.makeResult(
            wrong, right, times, memoryTimes, visualArrayChangeScore);

        sWidget.onResultChange(taskResults.results);
        if (sWidget.activity.includeResults) {
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        visualScore += 1;
        right += 1;
        resetTest();
      }
    } else {
      wrong += 1;
      if (viscurrentNum > numberOfTests) {
        sWidget.eventLogger.testEnded();
        var visualArrayChangeScore =
            sWidget.activity.calculateScore({'correct': right});
        RPVisualArrayChangeResult flankerResult = new RPVisualArrayChangeResult(
            identifier: 'visualArrayChangeResults');
        var taskResults = flankerResult.makeResult(
            wrong, right, times, memoryTimes, visualArrayChangeScore);

        sWidget.onResultChange(taskResults.results);
        if (sWidget.activity.includeResults) {
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        resetTest();
      }
    }
  }

  void different() {
    _timer.cancel();
    times.add(seconds);
    seconds = 0;
    if (changed) {
      if (viscurrentNum > numberOfTests) {
        visualScore += 1;
        right += 1;
        sWidget.eventLogger.testEnded();
        var visualArrayChangeScore =
            sWidget.activity.calculateScore({'correct': right});
        RPVisualArrayChangeResult flankerResult = new RPVisualArrayChangeResult(
            identifier: 'visualArrayChangeResults');
        var taskResults = flankerResult.makeResult(
            wrong, right, times, memoryTimes, visualArrayChangeScore);

        sWidget.onResultChange(taskResults.results);
        if (sWidget.activity.includeResults) {
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        visualScore += 1;
        right += 1;
        resetTest();
      }
    } else {
      if (viscurrentNum > numberOfTests) {
        sWidget.eventLogger.testEnded();
        var visualArrayChangeScore =
            sWidget.activity.calculateScore({'correct': right});
        RPVisualArrayChangeResult flankerResult = new RPVisualArrayChangeResult(
            identifier: 'visualArrayChangeResults');
        var taskResults = flankerResult.makeResult(
            wrong, right, times, memoryTimes, visualArrayChangeScore);

        sWidget.onResultChange(taskResults.results);
        if (sWidget.activity.includeResults) {
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        resetTest();
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height - 270,
          width: MediaQuery.of(context).size.width - 20,
          child: !waiting
              ? LayoutBuilder(builder: (context, constraints) {
                  final avatarSize = 100.0;
                  return Stack(
                    children: [
                      new Positioned(
                          left: avatarSize +
                              (constraints.biggest.width - 2 * avatarSize) /
                                  100.0 *
                                  rotation[0],
                          top: avatarSize +
                              (constraints.biggest.height - 2 * avatarSize) /
                                  100.0 *
                                  rotation[1],
                          child: new CircleAvatar(
                              radius: avatarSize / 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            hourglass[color[0]].urlImage),
                                        fit: BoxFit.scaleDown)),
                              ),
                              backgroundColor: Colors.transparent)),
                      new Positioned(
                          left: avatarSize +
                              (constraints.biggest.width - 2 * avatarSize) /
                                  100.0 *
                                  rotation[2],
                          top: avatarSize +
                              (constraints.biggest.height - 2 * avatarSize) /
                                  100.0 *
                                  rotation[3],
                          child: new CircleAvatar(
                              radius: avatarSize / 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            arrow[color[1]].urlImage),
                                        fit: BoxFit.scaleDown)),
                              ),
                              backgroundColor: Colors.transparent)),
                      new Positioned(
                          left: avatarSize +
                              (constraints.biggest.width - 2 * avatarSize) /
                                  100.0 *
                                  rotation[4],
                          top: avatarSize +
                              (constraints.biggest.height - 2 * avatarSize) /
                                  100.0 *
                                  rotation[5],
                          child: new CircleAvatar(
                              radius: avatarSize / 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image:
                                            AssetImage(top[color[2]].urlImage),
                                        fit: BoxFit.scaleDown)),
                              ),
                              backgroundColor: Colors.transparent)),
                    ],
                  );
                })
              : Center(
                  child: Container(
                      child: Text(
                  "wait",
                  style: TextStyle(fontSize: 25),
                ))),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: !guess
                    ? waiting
                        ? Container()
                        : Column(children: [
                            // ignore: deprecated_member_use
                            OutlineButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
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
                            Padding(
                                padding: EdgeInsets.only(top: 6),
                                child:
                                    Text("task $viscurrentNum/$numberOfTests"))
                          ])
                    : finished
                        ? Center(
                            child: Container(
                            child: Text(
                              'Click next to continue',
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                        : Row(children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                // ignore: deprecated_member_use
                                child: OutlineButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  onPressed: () {
                                    same();
                                  },
                                  child: Text(
                                    'Same',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )),
                            // ignore: deprecated_member_use
                            OutlineButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              onPressed: () {
                                different();
                              },
                              child: Text(
                                'Different',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ])),
          ),
        )
      ])));

  Widget buildShape(int index, Shape picture, double left, double top,
          double right, double bottom) =>
      Padding(
          padding: padding[picture.index],
          child: Transform.rotate(
              angle: 3.14 / rotation[picture.index],
              child: Container(
                  height: 150,
                  width: 50,
                  key: ValueKey(picture),
                  child: ReorderableDragStartListener(
                      index: index,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage(picture.urlImage),
                                fit: BoxFit.scaleDown)),
                      )))));
}

class Shape {
  String name;
  String urlImage;
  int index;

  Shape({
    required this.name,
    required this.urlImage,
    required this.index,
  });
}

class RPUIVisualArrayChangeActivityBody extends StatefulWidget {
  final RPVisualArrayChangeActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityEventLogger eventLogger;

  RPUIVisualArrayChangeActivityBody(
      this.activity, this.eventLogger, this.onResultChange);

  @override
  _RPUI_VisualArrayChangeActivityBodyState createState() =>
      _RPUI_VisualArrayChangeActivityBodyState();
}

// ignore: camel_case_types
class _RPUI_VisualArrayChangeActivityBodyState
    extends State<RPUIVisualArrayChangeActivityBody> {
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
      startTest();
    }
  }

  void startTest() async {
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
                'Memorize the colors of the shapes.',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Once ready the shapes will change positions.',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Indicate if ANY of the shapes changed color or if ALL shapes remained the same',
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
                            'packages/cognition_package/assets/images/shape_recall.png'))),
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
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('FLANKER TEST SCORE: ${score}'),
          // ),
          body: Center(
              child: VisualArrayChange(
                  sWidget: widget,
                  numberOfTests: widget.activity.numberOfTests,
                  waitTime: widget.activity.waitTime)),
        );
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
