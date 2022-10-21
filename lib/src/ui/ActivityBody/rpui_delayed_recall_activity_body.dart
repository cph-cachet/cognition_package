part of cognition_package_ui;

/// The [RPUIDelayedRecallActivityBody] class defines the UI for the
/// instructions and test phase of the continuous visual tracking task.
class RPUIDelayedRecallActivityBody extends StatefulWidget {
  /// The [RPUIDelayedRecallActivityBody] activity.
  final RPDelayedRecallActivity activity;

  /// The results function for the [RPUIDelayedRecallActivityBody].
  final void Function(dynamic) onResultChange;

  /// the [RPActivityEventLogger] for the [RPUIDelayedRecallActivityBody].
  final RPActivityEventLogger eventLogger;

  /// The [RPUIDelayedRecallActivityBody] constructor.
  const RPUIDelayedRecallActivityBody(
      this.activity, this.eventLogger, this.onResultChange,
      {super.key});

  @override
  RPUIDelayedRecallActivityBodyState createState() =>
      RPUIDelayedRecallActivityBodyState();
}

class RPUIDelayedRecallActivityBodyState
    extends State<RPUIDelayedRecallActivityBody> {
  ActivityStatus activityStatus = ActivityStatus.Instruction;

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
            const Padding(
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
              padding: const EdgeInsets.all(20),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'Write the words you recall in the boxes and click ',
                          style: TextStyle(fontSize: 16)),
                      TextSpan(
                          text: '"guess" ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ]),
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
                            'packages/cognition_package/assets/images/delayed_recall.png'))),
              ),
            ),
            SizedBox(
              //width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffC32C39),
                  fixedSize: const Size(300, 60),
                ),
                child: const Text(
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
                child: DelayedRecall(
          sWidget: widget,
          numberOfTests: widget.activity.numberOfTests,
        )));
      case ActivityStatus.Result:
        return Center(
          child: Text(
            'results:  $score',
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
      default:
        return Container();
    }
  }
}

class DelayedRecall extends StatefulWidget {
  final RPUIDelayedRecallActivityBody sWidget;
  final int numberOfTests;

  const DelayedRecall({
    Key? key,
    required this.sWidget,
    required this.numberOfTests,
  }) : super(key: key);

  @override
  DelayedRecallState createState() =>
      DelayedRecallState(sWidget, numberOfTests);
}

class DelayedRecallState extends State<DelayedRecall> {
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
  late SoundService soundService;

  DelayedRecallState(this.sWidget, this.numberOfTests);

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

  Timer? timer;
  int seconds = 0;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
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
    timer?.cancel();
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
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
              body: ListView(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 10, top: 20),
                child: Row(children: const <Widget>[
                  Text(
                    'Enter the words you recall',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  )
                ])),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      wordlist2[0] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            Container(height: 20),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      wordlist2[1] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            Container(height: 20),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      wordlist2[2] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            Container(height: 20),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      wordlist2[3] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            Container(height: 20),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextField(
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {
                      wordlist2[4] = text;
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()))),
            const SizedBox(
              height: 550,
            ),
          ]))),
      SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: finished
            ? const Center(
                child: Text(
                'Click next to continue',
                style: TextStyle(fontSize: 18),
              ))
            : OutlinedButton(
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
                  makeGuess();
                },
                child: const Text(
                  'Guess',
                  style: TextStyle(fontSize: 18),
                ),
              ),
      ),
    ])));
  }
}
