part of cognition_package_ui;

/// The [RPUIVisualArrayChangeActivityBody] class defines the UI for the
/// instructions and test phase of the continuous visual tracking task.
class RPUIVisualArrayChangeActivityBody extends StatefulWidget {
  /// The [RPUIVisualArrayChangeActivityBody] activity.
  final RPVisualArrayChangeActivity activity;

  /// The results function for the [RPUIVisualArrayChangeActivityBody].
  final void Function(dynamic) onResultChange;

  /// the [RPActivityEventLogger] for the [RPUIVisualArrayChangeActivityBody].
  final RPActivityEventLogger eventLogger;

  /// The [RPUIVisualArrayChangeActivityBody] constructor.
  const RPUIVisualArrayChangeActivityBody(
    this.activity,
    this.eventLogger,
    this.onResultChange, {
    super.key,
  });

  @override
  RPUIVisualArrayChangeActivityBodyState createState() =>
      RPUIVisualArrayChangeActivityBodyState();
}

/// score counter for the visual array change task used in [RPUIVisualArrayChangeActivityBody]
int visualArrayChangeScore = 0;

class RPUIVisualArrayChangeActivityBodyState
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
      if (mounted) {
        widget.eventLogger.testEnded();
        widget.onResultChange({'Correct swipes': visualArrayChangeScore});
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
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Memorize the colors of the shapes.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Once ready the shapes will change positions.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Indicate if ANY of the shapes changed color or if ALL shapes remained the same',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'packages/cognition_package/assets/images/shape_recall.png'))),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                onPressed: () {
                  widget.eventLogger.instructionEnded();
                  widget.eventLogger.testStarted();
                  setState(() {
                    activityStatus = ActivityStatus.Test;
                  });
                  startTest();
                },
                child: const Text(
                  'Ready',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      case ActivityStatus.Test:
        return Scaffold(
          body: Center(
              child: _VisualArrayChange(
                  sWidget: widget,
                  numberOfTests: widget.activity.numberOfTests,
                  numberOfShapes: widget.activity.numberOfShapes,
                  waitTime: widget.activity.waitTime)),
        );
      case ActivityStatus.Result:
        return Center(
          child: Text(
            'results:  $visualArrayChangeScore',
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
      default:
        return Container();
    }
  }
}

class _VisualArrayChange extends StatefulWidget {
  final RPUIVisualArrayChangeActivityBody sWidget;
  final int numberOfTests;
  final int numberOfShapes;
  final int waitTime;

  const _VisualArrayChange(
      {Key? key,
      required this.sWidget,
      required this.numberOfTests,
      required this.numberOfShapes,
      required this.waitTime})
      : super(key: key);

  @override
  _VisualArrayChangeState createState() =>
      _VisualArrayChangeState(sWidget, numberOfTests, numberOfShapes, waitTime);
}

class _VisualArrayChangeState extends State<_VisualArrayChange> {
  final RPUIVisualArrayChangeActivityBody sWidget;
  final int numberOfTests;
  final int numberOfShapes;
  final int waitTime;
  List<_Shape> original = [];
  List<_Shape> pictures = [];
  List<_Shape> top = [];
  List<_Shape> arrow = [];
  List<_Shape> hourglass = [];
  List<_Shape> bowl = [];
  List<_Shape> bean = [];
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

  List<String> beans = [
    'packages/cognition_package/assets/images/bean_1.png',
    'packages/cognition_package/assets/images/bean_2.png',
    'packages/cognition_package/assets/images/bean_3.png',
    'packages/cognition_package/assets/images/bean_4.png',
    'packages/cognition_package/assets/images/bean_5.png',
  ];

  List<String> bowls = [
    'packages/cognition_package/assets/images/bowl_1.png',
    'packages/cognition_package/assets/images/bowl_2.png',
    'packages/cognition_package/assets/images/bowl_3.png',
    'packages/cognition_package/assets/images/bowl_4.png',
    'packages/cognition_package/assets/images/bowl_5.png',
  ];

  List<Positioned> makeShapes(
    int numberOfShapes,
    BoxConstraints constraints,
    int avatarSize,
  ) {
    List<Positioned> shapes = [];
    top = getPictures(tops);
    hourglass = getPictures(hourglasses);
    arrow = getPictures(arrows);
    bowl = getPictures(bowls);
    bean = getPictures(beans);
    var shape = [arrow, top, hourglass, bowl, bean];

    for (int i = 0; i < numberOfShapes; i++) {
      shapes.add(
        Positioned(
            left: avatarSize +
                (constraints.biggest.width - 2 * avatarSize) /
                    100.0 *
                    rotation[i],
            top: avatarSize +
                (constraints.biggest.height - 2 * avatarSize) /
                    100.0 *
                    rotation[i + 1],
            child: CircleAvatar(
                radius: avatarSize / 2,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: AssetImage(shape[i][color[i]].urlImage),
                          fit: BoxFit.scaleDown)),
                ))),
      );
    }
    return shapes;
  }

  _VisualArrayChangeState(
      this.sWidget, this.numberOfTests, this.numberOfShapes, this.waitTime);
  List<_Shape> getPictures(List<String> list) => List.generate(
        5,
        (index) => _Shape(
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
    for (_Shape picl in pictures) {
      original.add(picl);
    }
    memorySeconds = 0;
    startMemoryTimer();
  }

  List<Positioned> shapes = [];
  List<int> getRotation() => List.generate(10, (index) => rng.nextInt(100));
  List<int> getColor() => List.generate(5, (index) => rng.nextInt(5));

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
      for (_Shape picl in pictures) {
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
    await Future<dynamic>.delayed(Duration(seconds: waitTime));
    setState(() {
      waiting = false;
      guess = true;
    });
    startTimer();
  }

  var rng = Random();

  late Timer _timer;
  int seconds = 0;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
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
    const oneSec = Duration(seconds: 1);
    memoryTimer = Timer.periodic(
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

        visualArrayChangeScore =
            sWidget.activity.calculateScore({'correct': right, 'wrong': wrong});
        RPVisualArrayChangeResult visualArrayChangeResult =
            RPVisualArrayChangeResult(identifier: 'visualArrayChangeResults');
        var taskResults = visualArrayChangeResult.makeResult(
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
            sWidget.activity.calculateScore({'correct': right, 'wrong': wrong});
        RPVisualArrayChangeResult visualArrayChangeResult =
            RPVisualArrayChangeResult(identifier: 'visualArrayChangeResults');
        var taskResults = visualArrayChangeResult.makeResult(
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
            sWidget.activity.calculateScore({'correct': right, 'wrong': wrong});
        RPVisualArrayChangeResult visualArrayChangeResult =
            RPVisualArrayChangeResult(identifier: 'visualArrayChangeResults');
        var taskResults = visualArrayChangeResult.makeResult(
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
            sWidget.activity.calculateScore({'correct': right, 'wrong': wrong});
        RPVisualArrayChangeResult visualArrayChangeResult =
            RPVisualArrayChangeResult(identifier: 'visualArrayChangeResults');
        var taskResults = visualArrayChangeResult.makeResult(
            wrong, right, times, memoryTimes, visualArrayChangeScore);

        sWidget.onResultChange(taskResults.results);
        if (sWidget.activity.includeResults) {
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        } else {
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
        SizedBox(
          height: MediaQuery.of(context).size.height - 270,
          width: MediaQuery.of(context).size.width - 20,
          child: !waiting
              ? LayoutBuilder(builder: (context, constraints) {
                  const avatarSize = 100;
                  return Stack(
                    children:
                        makeShapes(numberOfShapes, constraints, avatarSize),
                  );
                })
              : const Center(
                  child: Text(
                  'wait',
                  style: TextStyle(fontSize: 25),
                )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: !guess
                  ? waiting
                      ? Container()
                      : Column(children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            onPressed: () {
                              startTest();
                            },
                            child: const Text(
                              'Start',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text('task $viscurrentNum/$numberOfTests'))
                        ])
                  : finished
                      ? const Center(
                          child: Text(
                          'Click next to continue',
                          style: TextStyle(fontSize: 18),
                        ))
                      : Row(children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 16),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  same();
                                },
                                child: const Text(
                                  'Same',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )),
                          OutlinedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            onPressed: () {
                              different();
                            },
                            child: const Text(
                              'Different',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ])),
        )
      ])));

  Widget buildShape(int index, _Shape picture, double left, double top,
          double right, double bottom) =>
      Padding(
          padding: padding[picture.index],
          child: Transform.rotate(
              angle: 3.14 / rotation[picture.index],
              child: SizedBox(
                  height: 150,
                  width: 50,
                  key: ValueKey(picture),
                  child: ReorderableDragStartListener(
                      index: index,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage(picture.urlImage),
                                fit: BoxFit.scaleDown)),
                      )))));
}

class _Shape {
  String name;
  String urlImage;
  int index;

  _Shape({
    required this.name,
    required this.urlImage,
    required this.index,
  });
}
