part of cognition_package_ui;

var pictureScoreList = [];
var pictureTimesList = [];
var pictureMovesList = [];
var memorySecondList = [];
var picCurrentNum = 1;
var pictureScore = 0;
var moves = 0;

class PictureSequenceMemory extends StatefulWidget {
  final RPUIPictureSequenceMemoryActivityBody sWidget;
  final int numberOfTests;
  final int numberOfPics;
  const PictureSequenceMemory(
      {Key? key,
      required this.sWidget,
      required this.numberOfTests,
      required this.numberOfPics})
      : super(key: key);

  @override
  _PictureSequenceMemoryState createState() =>
      _PictureSequenceMemoryState(sWidget, numberOfTests, numberOfPics);
}

class _PictureSequenceMemoryState extends State<PictureSequenceMemory> {
  final RPUIPictureSequenceMemoryActivityBody sWidget;
  final int numberOfTestsPIC;
  final int numberOfPics;
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

  _PictureSequenceMemoryState(
      this.sWidget, this.numberOfTestsPIC, this.numberOfPics);

  List<Picture> getPictures(int start, int end, int num) => List.generate(
        num,
        (index) => Picture(
          name: index.toString(),
          urlImage: urlImages[index + start],
        ),
      );

  void resetTest() async {
    memorySeconds = 0;
    startMemoryTimer();
    setState(() {
      seconds = 0;
      waiting = false;
      guess = false;
      var start = numberOfPics * (picCurrentNum - 1);
      var end = start + numberOfPics;
      pictures = [];
      pictures = getPictures(start, end, numberOfPics);
      pictures.shuffle();
      _tiles = [];
      for (int i = 0; i < numberOfPics; i++) {
        _tiles.add(buildPicture(i, pictures[i]));
      }
      original = [];
      moves = 0;
      for (Picture picl in pictures) {
        original.add(picl);
      }
    });
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

  void startTest() async {
    memoryTimer.cancel();
    memorySecondList.add(memorySeconds);
    setState(() {
      picCurrentNum += 1;
      waiting = true;
      pictures.shuffle();
      _tiles = [];
      for (int i = 0; i < numberOfPics; i++) {
        _tiles.add(buildPicture(i, pictures[i]));
      }
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      waiting = false;
      guess = true;
    });
    startTimer();
  }

  late Timer picTimer;
  int seconds = 0;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    picTimer = Timer.periodic(
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
    var newScore = 0;
    for (var i = 1; i < pictures.length; i++) {
      var picPair = [pictures[i - 1].name, pictures[i].name];
      var picPair2 = [original[i - 1].name, original[i].name];

      if (listEquals(picPair, picPair2)) {
        newScore += 1;
      }
    }

    if (picCurrentNum > numberOfTestsPIC) {
      pictureTimesList.add(seconds);
      pictureScoreList.add(newScore);
      pictureMovesList.add(moves);
      sWidget.eventLogger.testEnded();

      var pictureSequenceScore =
          sWidget.activity.calculateScore({'pairs': pictureScoreList});

      RPPictureSequenceResult flankerResult =
          RPPictureSequenceResult(identifier: 'PictureSequenceResult');
      var taskResults = flankerResult.makeResult(
          pictureMovesList,
          pictureScoreList,
          pictureTimesList,
          memorySecondList,
          pictureSequenceScore);

      sWidget.onResultChange(taskResults.results);

      if (sWidget.activity.includeResults) {
        picTimer.cancel();
        sWidget.eventLogger.resultsShown();
        setState(() {
          finished = true;
        });
      } else {
        picTimer.cancel();
        sWidget.eventLogger.resultsShown();
        setState(() {
          finished = true;
        });
      }
    } else {
      pictureScoreList.add(seconds);
      pictureMovesList.add(moves);
      picTimer.cancel();
      resetTest();
    }
  }

  late List<Widget> _tiles;

  @override
  initState() {
    super.initState();
    pictures = getPictures(0, numberOfPics, numberOfPics);

    pictures.shuffle();
    for (Picture picl in pictures) {
      original.add(picl);
    }
    _tiles = [];
    memorySeconds = 0;
    for (int i = 0; i < numberOfPics; i++) {
      _tiles.add(buildPicture(i, pictures[i]));
    }
    startMemoryTimer();
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        moves = moves + 1;
        final picture = _tiles.removeAt(oldIndex);
        _tiles.insert(newIndex, picture);
        final _picture = pictures.removeAt(oldIndex);
        pictures.insert(newIndex, _picture);
      });
    }

    wrap(bool reorder) => ReorderableWrap(
          needsLongPressDraggable: reorder,
          spacing: 8.0,
          runSpacing: 4.0,
          padding: const EdgeInsets.all(8),
          children: _tiles,
          onReorder: _onReorder,
        );

    return Scaffold(
        body: Center(
            child: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height - 280,
        width: MediaQuery.of(context).size.width,
        child: !guess
            ? !waiting
                ? wrap(true)
                : Center(
                    child: Container(
                        child: Text(
                    'wait',
                    style: TextStyle(fontSize: 25),
                  )))
            : !waiting
                ? wrap(false)
                : Center(
                    child: Container(
                        child: Text(
                    'wait',
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
                      // ignore: deprecated_member_use
                      OutlineButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                    ])
              : finished
                  ? Center(
                      child: Container(
                      child: Text(
                        'Click next to continue',
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
                  // ignore: deprecated_member_use
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
  }

  Widget buildPicture(int index, Picture picture) => Container(
      height: 110,
      width: 110,
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

// ignore: camel_case_types
class _RPUI_PictureSequenceMemoryActivityBodyState
    extends State<RPUIPictureSequenceMemoryActivityBody> {
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
      if (mounted) {
        widget.eventLogger.testEnded();
        widget.onResultChange({'Correct swipes': score});
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
                'Memorize the order of images.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Once memorized click the ',
                          style: TextStyle(fontSize: 16)),
                      TextSpan(
                          text: '"ready" ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff003F6E),
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: 'button and the images will change positions.',
                          style: TextStyle(fontSize: 16)),
                    ]),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'Drag and drop the images to their original positions and press ',
                          style: TextStyle(fontSize: 16)),
                      TextSpan(
                          text: '"guess" ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff003F6E),
                              fontWeight: FontWeight.bold)),
                    ]),
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
                            'packages/cognition_package/assets/images/picture_sequence.png'))),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffC32C39),
                  fixedSize: const Size(300, 60),
                ),
                child: Text(
                  'Ready',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  widget.eventLogger.instructionEnded();
                  widget.eventLogger.testStarted();
                  setState(() {
                    activityStatus = ActivityStatus.Test;
                  });
                  startTest();
                },
              ),
            ),
          ],
        );
      case ActivityStatus.Test:
        return Scaffold(
            body: Center(
                child: PictureSequenceMemory(
                    sWidget: widget,
                    numberOfTests: widget.activity.numberOfTests,
                    numberOfPics: widget.activity.numberOfPics)));
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
