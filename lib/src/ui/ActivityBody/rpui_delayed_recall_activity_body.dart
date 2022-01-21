part of cognition_package_ui;

/// The [RPUIDelayedRecallActivityBody] class defines the UI for the
/// instructions and test phase of the continuous visual tracking task.
class RPUIDelayedRecallActivityBody extends StatefulWidget {
  /// The [RPUIDelayedRecallActivityBody] activity.
  final RPDelayedRecallActivity activity;

  /// The results function for the [RPUIDelayedRecallActivityBody].
  final Function(dynamic) onResultChange;

  /// the [RPActivityEventLogger] for the [RPUIDelayedRecallActivityBody].
  final RPActivityEventLogger eventLogger;

  /// The [RPUIDelayedRecallActivityBody] constructor.
  RPUIDelayedRecallActivityBody(
      this.activity, this.eventLogger, this.onResultChange);

  @override
  _RPUI_DelayedRecallActivityBodyState createState() =>
      _RPUI_DelayedRecallActivityBodyState();
}

// ignore: camel_case_types
class _RPUI_DelayedRecallActivityBodyState
    extends State<RPUIDelayedRecallActivityBody> {
  late ActivityStatus activityStatus;

  var score = 0;

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
              padding: EdgeInsets.all(20),
              child: Text(
                'Remember all the words you recall from the exercise earlier?',
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
                          text:
                              'Write the words you recall in the boxes and click ',
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
                            'packages/cognition_package/assets/images/delayed_recall.png'))),
              ),
            ),
            SizedBox(
              //width: MediaQuery.of(context).size.width / 2,
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
                },
              ),
            ),
          ],
        );
      case ActivityStatus.Test:
        return Scaffold(
            body: Center(
                child: _DelayedRecall(
          sWidget: widget,
          numberOfTests: widget.activity.numberOfTests,
        )));
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

class _DelayedRecall extends StatefulWidget {
  final RPUIDelayedRecallActivityBody sWidget;
  final int numberOfTests;

  const _DelayedRecall(
      {Key? key, required this.sWidget, required this.numberOfTests})
      : super(key: key);

  @override
  _DelayedRecallState createState() =>
      _DelayedRecallState(sWidget, numberOfTests);
}

class _DelayedRecallState extends State<_DelayedRecall> {
  final RPUIDelayedRecallActivityBody sWidget;
  final int numberOfTests;
  var timesTaken2 = [];
  List<String> resultsList3 = [];
  var timesTaken = [];
  List<String> wordlist = ['banana', 'icecream', 'violin', 'desk', 'green'];
  List<String> wordlist2 = ['', '', '', '', ''];
  bool waiting = false;
  bool guess = false;
  bool finished = false;
  int time = 0;
  late _SoundService soundService;

  _DelayedRecallState(this.sWidget, this.numberOfTests);

  void resetTest() async {
    setState(() {
      seconds = 0;
      waiting = false;
      guess = true;
    });
    startTest();
  }

  void startTest() async {
    startTimer();
  }

  /// Timer
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

  void makeGuess() {
    sWidget.eventLogger.testEnded();
    timesTaken.add(seconds);
    _timer.cancel();
    resultsList3 = wordlist2;
    var delayedRecallScore = sWidget.activity
        .calculateScore({'wordsList': wordlist, 'resultsList': resultsList3});

    RPDelayedRecallResult result =
        RPDelayedRecallResult(identifier: 'DelayedRecallResult');
    var taskResults =
        result.makeResult(wordlist, resultsList3, seconds, delayedRecallScore);

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
  }

  @override
  initState() {
    super.initState();
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
          child: Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      wordlist2[0] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            Container(height: 20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      wordlist2[1] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            Container(height: 20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      wordlist2[2] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            Container(height: 20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      wordlist2[3] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            Container(height: 20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {
                      wordlist2[4] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            SizedBox(
              height: 550,
            ),
          ]))),
      Container(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: finished
              ? Center(
                  child: Container(
                  child: Text(
                    'Click next to continue',
                    style: TextStyle(fontSize: 18),
                  ),
                ))
              // ignore: deprecated_member_use
              : OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
