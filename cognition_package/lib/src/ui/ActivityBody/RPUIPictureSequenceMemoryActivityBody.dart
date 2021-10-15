part of cognition_package_ui;

var pictureScoreList = [];
var numberOfTest = 3;
var currentNum = 1;
var PictureScore = 0;

class PictureSequenceMemory extends StatefulWidget {
  final RPUIPictureSequenceMemoryActivityBody sWidget;
  const PictureSequenceMemory({Key? key, required this.sWidget})
      : super(key: key);

  @override
  _PictureSequenceMemoryState createState() =>
      _PictureSequenceMemoryState(sWidget);
}

class _PictureSequenceMemoryState extends State<PictureSequenceMemory> {
  final RPUIPictureSequenceMemoryActivityBody sWidget;
  // Dynamically load cards from database
  List<Picture> original = [];
  List<Picture> pictures = [];
  bool waiting = false;
  bool guess = false;
  bool finished = false;
  int time = 0;
  final urlImages = [
    'https://images.unsplash.com/photo-1554456854-55a089fd4cb2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1470&q=80',
    'https://images.unsplash.com/photo-1467224298296-81a33a3f3022?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1413&q=80',
    'https://images.unsplash.com/photo-1581889470536-467bdbe30cd0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1564&q=80',
    'https://images.unsplash.com/photo-1489824904134-891ab64532f1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1631&q=80',
    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
    'https://images.unsplash.com/photo-1552058544-f2b08422138a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=644&q=80',
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1555952517-2e8e729e0b44?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80',
    'https://images.unsplash.com/photo-1543080853-556086153871?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1584361853901-dd1904bb7987?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1548543604-a87c9909abec?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1548794397-eeedae69ac71?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1585129819171-80b02d4c85b0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  ];

  _PictureSequenceMemoryState(this.sWidget);
  List<Picture> getPictures() => List.generate(
        4,
        (index) => Picture(
          name: index.toString(),
          urlImage: urlImages[index],
        ),
      );

  void resetTest() async {
    print("resetting now");
    setState(() {
      seconds = 0;
      waiting = false;
      guess = false;
      pictures.shuffle();
      original = [];
      for (Picture picl in pictures) {
        print(picl.name);
        original.add(picl);
      }
    });
  }

  void startTest() async {
    print("trying now");
    setState(() {
      currentNum += 1;
      waiting = true;
      pictures.shuffle();
    });
    for (Picture pic in original) {
      print(pic.name);
    }
    print("----------");
    for (Picture picl in pictures) {
      print(picl.name);
    }
    //sleep(Duration(seconds: 2));
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      waiting = false;
      guess = true;
    });
    startTimer();
  }

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

  void makeGuess() {
    print("GUESS IS: ");
    for (Picture picl in pictures) {
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
  initState() {
    super.initState();
    pictures = getPictures();
    pictures.shuffle();
    for (Picture picl in pictures) {
      print(picl.name);
      original.add(picl);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height - 210,
          width: MediaQuery.of(context).size.width - 20,
          child: !guess
              ? !waiting
                  ? ReorderableListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pictures.length,
                      onReorder: (oldIndex, newIndex) => setState(() {
                        final index =
                            newIndex > oldIndex ? newIndex - 1 : newIndex;

                        final picture = pictures.removeAt(oldIndex);
                        pictures.insert(index, picture);
                      }),
                      itemBuilder: (context, index) {
                        final picture = pictures[index];

                        return Padding(
                            key: ValueKey(picture),
                            padding: EdgeInsets.all(5),
                            child: buildNonDraggablePicture(index, picture));
                      },
                    )
                  : Center(
                      child: Container(
                          child: Text(
                      "wait",
                      style: TextStyle(fontSize: 25),
                    )))
              : !waiting
                  ? ReorderableListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pictures.length,
                      onReorder: (oldIndex, newIndex) => setState(() {
                        final index =
                            newIndex > oldIndex ? newIndex - 1 : newIndex;

                        final picture = pictures.removeAt(oldIndex);
                        pictures.insert(index, picture);
                      }),
                      itemBuilder: (context, index) {
                        final picture = pictures[index];

                        return Padding(
                            key: ValueKey(picture),
                            padding: EdgeInsets.all(5),
                            child: buildPicture(index, picture));
                      },
                    )
                  : Center(
                      child: Container(
                          child: Text(
                      "wait",
                      style: TextStyle(fontSize: 25),
                    ))),
        ),
        Container(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: !guess
                ? waiting
                    ? Container()
                    : Column(children: [
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
                            'Ready',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Text("task $currentNum/$numberOfTest")
                      ])
                : finished
                    ? Center(
                        child: Container(
                        child: Text(
                          'Correct',
                          style: TextStyle(fontSize: 18),
                        ),
                      ))
                    : OutlineButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        onPressed: () {
                          makeGuess();
                        },
                        child: Text(
                          'Guess',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
          ),
        ),
      ])));

  Widget buildPicture(int index, Picture picture) => Container(
      height: 125,
      width: 50,
      key: ValueKey(picture),
      child: ReorderableDragStartListener(
          index: index,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(picture.urlImage),
                  fit: BoxFit.cover,
                )),
          )));

  Widget buildNonDraggablePicture(int index, Picture picture) => Container(
      height: 125,
      width: 50,
      key: ValueKey(picture),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              image: NetworkImage(picture.urlImage),
              fit: BoxFit.cover,
            )),
      ));
}

class Picture {
  String name;
  String urlImage;

  Picture({
    required this.name,
    required this.urlImage,
  });
}

class RPUIPictureSequenceMemoryActivityBody extends StatefulWidget {
  final RPPictureSequenceMemoryActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityEventLogger eventLogger;

  RPUIPictureSequenceMemoryActivityBody(
      this.activity, this.eventLogger, this.onResultChange);

  @override
  _RPUI_PictureSequenceMemoryActivityBodyState createState() =>
      _RPUI_PictureSequenceMemoryActivityBodyState();
}

class _RPUI_PictureSequenceMemoryActivityBodyState
    extends State<RPUIPictureSequenceMemoryActivityBody> {
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
                'memorize the order of images, once ready click the button and the images will change positions, drag and drop the images to their original positions',
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
          body: Center(child: PictureSequenceMemory(sWidget: widget)),
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
