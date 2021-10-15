part of cognition_package_ui;

class VisualArrayChange extends StatefulWidget {
  final RPUIVisualArrayChangeActivityBody sWidget;
  const VisualArrayChange({Key? key, required this.sWidget}) : super(key: key);

  @override
  _VisualArrayChangeState createState() => _VisualArrayChangeState(sWidget);
}

class _VisualArrayChangeState extends State<VisualArrayChange> {
  final RPUIVisualArrayChangeActivityBody sWidget;
  // Dynamically load cards from database
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
  int visnumberOfTest = 3;

  List<String> shapes = [
    'packages/cognitive_package/assets/images/arrow_blue.png',
    'packages/cognitive_package/assets/images/arrow_red.png',
    'packages/cognitive_package/assets/images/arrow_yellow.png',
    'packages/cognitive_package/assets/images/top_blue.png',
    'packages/cognitive_package/assets/images/top_red.png',
    'packages/cognitive_package/assets/images/top_yellow.png',
    'packages/cognitive_package/assets/images/hourglass_blue.png',
    'packages/cognitive_package/assets/images/hourglass_red.png',
    'packages/cognitive_package/assets/images/hourglass_yellow.png',
  ];
  List<String> arrows = [
    'packages/cognitive_package/assets/images/arrow_blue.png',
    'packages/cognitive_package/assets/images/arrow_red.png',
    'packages/cognitive_package/assets/images/arrow_yellow.png'
  ];

  List<String> tops = [
    'packages/cognitive_package/assets/images/top_blue.png',
    'packages/cognitive_package/assets/images/top_red.png',
    'packages/cognitive_package/assets/images/top_yellow.png',
  ];

  List<String> hourglasses = [
    'packages/cognitive_package/assets/images/hourglass_blue.png',
    'packages/cognitive_package/assets/images/hourglass_red.png',
    'packages/cognitive_package/assets/images/hourglass_yellow.png',
  ];

  _VisualArrayChangeState(this.sWidget);
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
    pictures = getPictures(shapes);
    padding = getPadding();
    rotation = getRotation();
    color = getColor();
    pictures.shuffle();
    for (Shape picl in pictures) {
      print(picl.name);
      original.add(picl);
    }
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
    print("resetting now");
    setState(() {
      changed = false;
      waiting = false;
      guess = false;
      pictures.shuffle();
      //shapes.shuffle();
      padding = getPadding();
      rotation = getRotation();
      color = getColor();
      original = [];
      for (Shape picl in pictures) {
        print(picl.name);
        original.add(picl);
      }
    });
  }

  void startTest() async {
    print("trying now");

    if (rng.nextBool()) {
      print("CHANGE THE FUCKING COLORS");
      //print(color);
      List<int> og = color;
      print("OG: $og");
      color = getColor();
      if (color != og) {
        print("Changed colors");
        print("Color: $color");
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
    //sleep(Duration(seconds: 2));
    await Future.delayed(Duration(seconds: 2));
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

  void same() {
    if (!changed) {
      print("Good Job");
      if (viscurrentNum > visnumberOfTest) {
        visualScore += 1;
        sWidget.eventLogger.testEnded();
        sWidget.onResultChange({"scores: ": visualScore});
        if (sWidget.activity.includeResults) {
          _timer.cancel();
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        visualScore += 1;
        _timer.cancel();
        resetTest();
      }
    } else {
      print("bad Job");
      if (viscurrentNum > visnumberOfTest) {
        sWidget.eventLogger.testEnded();
        sWidget.onResultChange({"scores: ": visualScore});
        if (sWidget.activity.includeResults) {
          _timer.cancel();
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        _timer.cancel();
        resetTest();
      }
    }
  }

  void different() {
    if (changed) {
      print("Good Job");
      if (viscurrentNum > visnumberOfTest) {
        visualScore += 1;
        sWidget.eventLogger.testEnded();
        sWidget.onResultChange({"scores: ": visualScore});
        if (sWidget.activity.includeResults) {
          _timer.cancel();
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        visualScore += 1;
        _timer.cancel();
        resetTest();
      }
    } else {
      print("bad Job");
      if (viscurrentNum > visnumberOfTest) {
        sWidget.eventLogger.testEnded();
        sWidget.onResultChange({"scores: ": visualScore});
        if (sWidget.activity.includeResults) {
          _timer.cancel();
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        _timer.cancel();
        resetTest();
      }
    }
  }

  void makeGuess() {
    print("GUESS IS: ");
    for (Shape picl in pictures) {
      print(picl.name);
    }
    if (listEquals(pictures, original)) {
      print("Good Job");
      if (currentNum > numberOfTest) {
        pictureScoreList.add(seconds);
        sWidget.eventLogger.testEnded();
        sWidget.onResultChange({"scores: ": pictureScoreList});
        if (sWidget.activity.includeResults) {
          _timer.cancel();
          sWidget.eventLogger.resultsShown();
          setState(() {
            finished = true;
          });
        }
      } else {
        pictureScoreList.add(seconds);
        _timer.cancel();
        resetTest();
      }
    } else {
      print("Try Again");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height - 235,
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
                            OutlineButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              onPressed: () {
                                startTest();
                              },
                              child: Text(
                                'Ready',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Text("task $viscurrentNum/$visnumberOfTest")
                          ])
                    : finished
                        ? Center(
                            child: Container(
                            child: Text(
                              'Correct',
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                        : Row(children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
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

class _RPUI_VisualArrayChangeActivityBodyState
    extends State<RPUIVisualArrayChangeActivityBody> {
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
                'memorize the colors of the shapes, once ready the shapes will change positions, in their new positions indicate if any of the shapes changed color or if all shapes remained the same',
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
        break;
      case ActivityStatus.Test:
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('FLANKER TEST SCORE: ${score}'),
          // ),
          body: Center(child: VisualArrayChange(sWidget: widget)),
        );
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
