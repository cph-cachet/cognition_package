part of cognition_package_ui;

var currentNum = 1;
var timesTaken = [];
List<String> resultsList1 = [];
List<String> resultsList2 = [];

class WordRecall extends StatefulWidget {
  final RPUIWordRecallActivityBody sWidget;
  final numberOfTests;

  const WordRecall({Key? key, required this.sWidget, this.numberOfTests})
      : super(key: key);

  @override
  _WordRecallState createState() => _WordRecallState(sWidget, numberOfTests);
}

class _WordRecallState extends State<WordRecall> {
  final RPUIWordRecallActivityBody sWidget;
  final int numberOfTests;

  List<String> wordlist = ['banana', 'icecream', 'violin', 'desk', 'green'];
  List<String> wordlist2 = ['', '', '', '', ''];
  bool waiting = false;
  bool guess = false;
  bool finished = false;
  int time = 0;
  late SoundService soundService;

  _WordRecallState(this.sWidget, this.numberOfTests);

  void resetTest() async {
    setState(() {
      seconds = 0;
      waiting = false;
      guess = false;
    });
    startTest();
  }

  void startTest() async {
    setState(() {
      currentNum += 1;
      waiting = true;
    });
    await Future.delayed(Duration(milliseconds: 1200));
    soundService.play('../packages/cognition_package/assets/sounds/BANANA.mp3');
    await Future.delayed(Duration(milliseconds: 1200));
    soundService
        .play('../packages/cognition_package/assets/sounds/ICECREAM.mp3');
    await Future.delayed(Duration(milliseconds: 1200));
    soundService.play('../packages/cognition_package/assets/sounds/VIOLIN.mp3');
    await Future.delayed(Duration(milliseconds: 1200));
    soundService.play('../packages/cognition_package/assets/sounds/DESK.mp3');
    await Future.delayed(Duration(milliseconds: 1200));
    soundService.play('../packages/cognition_package/assets/sounds/GREEN.mp3');

    await Future.delayed(Duration(seconds: 1));
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
    if (currentNum > 2) {
      resultsList2 = wordlist2;
      sWidget.eventLogger.testEnded();
      timesTaken.add(seconds);
      _timer.cancel();
      var word_recall_score = sWidget.activity
          .calculateScore({'wordsList': wordlist, 'resultsList': resultsList2});
      RPWordRecallResult result =
          new RPWordRecallResult(identifier: 'WordRecallResult');
      var taskResults = result.makeResult(
          wordlist, resultsList1, resultsList2, timesTaken, word_recall_score);

      sWidget.onResultChange(taskResults.results);
      if (sWidget.activity.includeResults) {
        sWidget.eventLogger.resultsShown();
        setState(() {
          finished = true;
        });
      }
    } else {
      resultsList1 = wordlist2;
      wordlist2 = ['', '', '', '', ''];
      timesTaken.add(seconds);
      _timer.cancel();
      resetTest();
    }
  }

  @override
  initState() {
    super.initState();
    List<String> alphabet = [
      'FACE',
      'VELVET',
      'CHURCH',
      'DAISY',
      'RED',
    ];
    soundService = SoundService(alphabet
        .map(
            (item) => ('../packages/cognition_package/assets/sounds/$item.mp3'))
        .toList());
    startTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height - 280,
        width: MediaQuery.of(context).size.width,
        child: !guess
            ? !waiting
                ? Text('ready')
                : Center(
                    child: Container(
                        child: Text(
                    "listen",
                    style: TextStyle(fontSize: 25),
                  )))
            : !waiting
                ? Scaffold(
                    body: ListView(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 25, bottom: 10, top: 20),
                        child: Row(children: <Widget>[
                          Text(
                            'Enter the words you recall',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                          )
                        ])),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                        child: TextField(
                            textInputAction: TextInputAction.next,
                            onChanged: (text) {
                              wordlist2[0] = text;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()))),
                    Container(height: 20),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                        child: TextField(
                            textInputAction: TextInputAction.next,
                            onChanged: (text) {
                              wordlist2[1] = text;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()))),
                    Container(height: 20),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                        child: TextField(
                            textInputAction: TextInputAction.next,
                            onChanged: (text) {
                              wordlist2[2] = text;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()))),
                    Container(height: 20),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                        child: TextField(
                            textInputAction: TextInputAction.next,
                            onChanged: (text) {
                              wordlist2[3] = text;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()))),
                    Container(height: 20),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                        child: TextField(
                            textInputAction: TextInputAction.done,
                            onChanged: (text) {
                              wordlist2[4] = text;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()))),
                    SizedBox(
                      height: 550,
                    ),
                  ]))
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      //Text("task $currentNum/${this.numberOfTests}")
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
  }
}

class RPUIWordRecallActivityBody extends StatefulWidget {
  final RPWordRecallActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityEventLogger eventLogger;

  RPUIWordRecallActivityBody(
      this.activity, this.eventLogger, this.onResultChange);

  @override
  _RPUI_WordRecallActivityBodyState createState() =>
      _RPUI_WordRecallActivityBodyState();
}

class _RPUI_WordRecallActivityBodyState
    extends State<RPUIWordRecallActivityBody> {
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

  @override
  Widget build(BuildContext context) {
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Turn on sound for this task.',
                          style: TextStyle(fontSize: 16)),
                    ]),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'A list of words will be read aloud, try to memorize the list of words.',
                          style: TextStyle(fontSize: 16)),
                    ]),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'After the words have been read aloud you will be asked to recall them.',
                          style: TextStyle(fontSize: 16)),
                    ]),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'Write the words you recall in the boxes in any order and click ',
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
            Container(height: 0),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'packages/cognition_package/assets/images/wordlist_recall.png'))),
              ),
            ),
            SizedBox(
              //width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffC32C39),
                  fixedSize: const Size(300, 60),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: Text(
                  "Ready",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  widget.eventLogger.instructionEnded();
                  widget.eventLogger.testStarted();
                  setState(() {
                    activityStatus = ActivityStatus.Test;
                  });
                },
              ),
            ),
          ],
        );
      case ActivityStatus.Test:
        return Scaffold(
            body: Center(
                child: WordRecall(
          sWidget: widget,
          numberOfTests: widget.activity.numberOfTests,
        )));
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
